-- ============================================
-- EXTENSIONES
-- ============================================

-- Habilitar extensión para Cron Jobs
CREATE EXTENSION IF NOT EXISTS pg_cron;

-- ============================================
-- TABLAS DE USUARIOS
-- ============================================

-- Tabla de perfiles de padres (extiende auth.users)
CREATE TABLE profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  avatar_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Habilitar RLS (Row Level Security)
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Policies para profiles
CREATE POLICY "Users can view own profile" 
  ON profiles FOR SELECT 
  USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" 
  ON profiles FOR UPDATE 
  USING (auth.uid() = id);

-- Tabla de niños (perfiles sin autenticación)
CREATE TABLE kids (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  parent_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  avatar_url TEXT,
  color TEXT, -- Para UI: 'blue', 'pink', 'green', etc.
  order_index INT DEFAULT 0, -- Para ordenar en la UI
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Índice para búsquedas por padre
CREATE INDEX idx_kids_parent ON kids(parent_id);

-- RLS para kids
ALTER TABLE kids ENABLE ROW LEVEL SECURITY;

-- Policies para kids
CREATE POLICY "Parents can view own kids" 
  ON kids FOR SELECT 
  USING (parent_id = auth.uid());

CREATE POLICY "Parents can insert own kids" 
  ON kids FOR INSERT 
  WITH CHECK (parent_id = auth.uid());

CREATE POLICY "Parents can update own kids" 
  ON kids FOR UPDATE 
  USING (parent_id = auth.uid());

CREATE POLICY "Parents can delete own kids" 
  ON kids FOR DELETE 
  USING (parent_id = auth.uid());

-- ============================================
-- TABLA DE PUNTOS
-- ============================================

CREATE TABLE kid_points (
  kid_id UUID PRIMARY KEY REFERENCES kids(id) ON DELETE CASCADE,
  total_points INT DEFAULT 0,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- RLS para kid_points
ALTER TABLE kid_points ENABLE ROW LEVEL SECURITY;

-- Policies para kid_points
CREATE POLICY "Parents can view kids points" 
  ON kid_points FOR SELECT 
  USING (
    kid_id IN (
      SELECT id FROM kids WHERE parent_id = auth.uid()
    )
  );

CREATE POLICY "Parents can update kids points" 
  ON kid_points FOR UPDATE 
  USING (
    kid_id IN (
      SELECT id FROM kids WHERE parent_id = auth.uid()
    )
  );

CREATE POLICY "System can insert kids points" 
  ON kid_points FOR INSERT 
  WITH CHECK (true); -- Los triggers necesitan insertar

-- ============================================
-- TABLAS DE TAREAS
-- ============================================

-- Tabla de plantillas de tareas
CREATE TABLE task_templates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  parent_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  points INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Índice para task_templates
CREATE INDEX idx_task_templates_parent ON task_templates(parent_id);

-- RLS para task_templates
ALTER TABLE task_templates ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Parents can manage own task templates" 
  ON task_templates FOR ALL 
  USING (parent_id = auth.uid())
  WITH CHECK (parent_id = auth.uid());

-- Tabla de configuración de tareas (schedules)
CREATE TABLE task_schedules (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_template_id UUID NOT NULL REFERENCES task_templates(id) ON DELETE CASCADE,
  kid_id UUID NOT NULL REFERENCES kids(id) ON DELETE CASCADE,
  days_of_week INT[], -- [0=Dom, 1=Lun, 2=Mar, 3=Mié, 4=Jue, 5=Vie, 6=Sáb]
  time_of_day TEXT CHECK (time_of_day IN ('morning', 'afternoon', 'evening', 'night')),
  specific_date DATE,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  
  CONSTRAINT check_schedule_type CHECK (
    days_of_week IS NOT NULL OR specific_date IS NOT NULL
  )
);

-- Índices para task_schedules
CREATE INDEX idx_task_schedules_kid ON task_schedules(kid_id);
CREATE INDEX idx_task_schedules_active ON task_schedules(is_active);
CREATE INDEX idx_task_schedules_specific_date ON task_schedules(specific_date);

-- RLS para task_schedules
ALTER TABLE task_schedules ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Parents can manage schedules for their kids" 
  ON task_schedules FOR ALL 
  USING (
    kid_id IN (
      SELECT id FROM kids WHERE parent_id = auth.uid()
    )
  )
  WITH CHECK (
    kid_id IN (
      SELECT id FROM kids WHERE parent_id = auth.uid()
    )
  );

-- Tabla de instancias de tareas
CREATE TABLE task_instances (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_schedule_id UUID NOT NULL REFERENCES task_schedules(id) ON DELETE CASCADE,
  kid_id UUID NOT NULL REFERENCES kids(id) ON DELETE CASCADE,
  due_date DATE NOT NULL,
  time_of_day TEXT NOT NULL,
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'completed', 'skipped')),
  completed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  
  UNIQUE(task_schedule_id, due_date)
);

-- Índices para task_instances
CREATE INDEX idx_task_instances_kid_date ON task_instances(kid_id, due_date);
CREATE INDEX idx_task_instances_status ON task_instances(status);
CREATE INDEX idx_task_instances_due_date ON task_instances(due_date);
CREATE INDEX idx_task_instances_schedule ON task_instances(task_schedule_id);

-- RLS para task_instances
ALTER TABLE task_instances ENABLE ROW LEVEL SECURITY;

-- Policies para task_instances
CREATE POLICY "Parents can manage task instances for their kids" 
  ON task_instances FOR ALL 
  USING (
    kid_id IN (
      SELECT id FROM kids WHERE parent_id = auth.uid()
    )
  )
  WITH CHECK (
    kid_id IN (
      SELECT id FROM kids WHERE parent_id = auth.uid()
    )
  );

-- ============================================
-- FUNCIONES PARA GENERACIÓN DE INSTANCIAS
-- ============================================

-- Función 1: Generar instancias para un schedule específico
CREATE OR REPLACE FUNCTION generate_instances_for_schedule(
  p_schedule_id UUID,
  p_days_ahead INT DEFAULT 7
)
RETURNS void AS $$
DECLARE
  schedule_record RECORD;
  check_date DATE;
  day_of_week INT;
BEGIN
  -- Obtener el schedule
  SELECT 
    ts.*,
    tt.title as task_title
  INTO schedule_record 
  FROM task_schedules ts
  JOIN task_templates tt ON tt.id = ts.task_template_id
  WHERE ts.id = p_schedule_id AND ts.is_active = true;
  
  -- Si no existe o no está activo, salir
  IF NOT FOUND THEN
    RETURN;
  END IF;
  
  -- Generar instancias desde HOY hasta p_days_ahead días en el futuro
  FOR i IN 0..(p_days_ahead - 1) LOOP
    check_date := CURRENT_DATE + i;
    day_of_week := EXTRACT(DOW FROM check_date)::INT;
    
    -- Verificar si debe generarse instancia para esta fecha
    IF (
      -- Caso 1: Es una tarea recurrente y coincide el día de la semana
      (schedule_record.days_of_week IS NOT NULL 
       AND schedule_record.days_of_week @> ARRAY[day_of_week])
      OR
      -- Caso 2: Es una tarea con fecha específica
      (schedule_record.specific_date IS NOT NULL 
       AND schedule_record.specific_date = check_date)
    ) THEN
      
      -- Insertar solo si no existe ya
      INSERT INTO task_instances (
        task_schedule_id,
        kid_id,
        due_date,
        time_of_day,
        status,
        created_at
      )
      VALUES (
        schedule_record.id,
        schedule_record.kid_id,
        check_date,
        COALESCE(schedule_record.time_of_day, 'morning'),
        'pending',
        NOW()
      )
      ON CONFLICT (task_schedule_id, due_date) 
      DO NOTHING;
      
    END IF;
  END LOOP;
  
  RAISE NOTICE 'Instancias generadas para schedule_id: %', p_schedule_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función 2: Generar instancias para TODOS los schedules activos
CREATE OR REPLACE FUNCTION generate_all_task_instances()
RETURNS void AS $$
DECLARE
  schedule_id UUID;
  schedules_count INT := 0;
BEGIN
  -- Para cada schedule activo
  FOR schedule_id IN 
    SELECT id FROM task_schedules WHERE is_active = true
  LOOP
    PERFORM generate_instances_for_schedule(schedule_id, 7);
    schedules_count := schedules_count + 1;
  END LOOP;
  
  RAISE NOTICE 'Generación completada para % schedules', schedules_count;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función 3: Limpiar instancias antiguas completadas
CREATE OR REPLACE FUNCTION cleanup_old_instances()
RETURNS void AS $$
DECLARE
  deleted_count INT;
BEGIN
  -- Eliminar instancias completadas de hace más de 30 días
  DELETE FROM task_instances
  WHERE status = 'completed'
  AND due_date < CURRENT_DATE - INTERVAL '30 days';
  
  GET DIAGNOSTICS deleted_count = ROW_COUNT;
  RAISE NOTICE 'Eliminadas % instancias antiguas', deleted_count;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función 4: Actualizar puntos del niño al completar tarea
CREATE OR REPLACE FUNCTION update_kid_points()
RETURNS TRIGGER AS $$
DECLARE
  task_points INT;
BEGIN
  -- Solo si cambió a 'completed'
  IF NEW.status = 'completed' AND (OLD.status IS NULL OR OLD.status != 'completed') THEN
    
    -- Obtener puntos de la tarea
    SELECT tt.points INTO task_points
    FROM task_schedules ts
    JOIN task_templates tt ON tt.id = ts.task_template_id
    WHERE ts.id = NEW.task_schedule_id;
    
    -- Insertar o actualizar puntos del niño
    INSERT INTO kid_points (kid_id, total_points, updated_at)
    VALUES (NEW.kid_id, COALESCE(task_points, 0), NOW())
    ON CONFLICT (kid_id) 
    DO UPDATE SET 
      total_points = kid_points.total_points + COALESCE(task_points, 0),
      updated_at = NOW();
    
    -- Registrar cuándo se completó
    NEW.completed_at := NOW();
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- TRIGGERS
-- ============================================

-- Trigger: Crear perfil automáticamente al registrarse
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, name, avatar_url)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'name', 'Usuario'),
    NEW.raw_user_meta_data->>'avatar_url'
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = public, auth;

ALTER FUNCTION public.handle_new_user() OWNER TO postgres;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();

-- Trigger: Generar instancias al crear un schedule
CREATE OR REPLACE FUNCTION on_schedule_created()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.is_active THEN
    PERFORM generate_instances_for_schedule(NEW.id, 7);
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER trigger_schedule_created
  AFTER INSERT ON task_schedules
  FOR EACH ROW
  EXECUTE FUNCTION on_schedule_created();

-- Trigger: Regenerar instancias al reactivar o modificar un schedule
CREATE OR REPLACE FUNCTION on_schedule_updated()
RETURNS TRIGGER AS $$
BEGIN
  -- Si se activó un schedule que estaba inactivo
  IF NEW.is_active = true AND OLD.is_active = false THEN
    PERFORM generate_instances_for_schedule(NEW.id, 7);
  END IF;
  
  -- Si se modificaron los días o la fecha específica
  IF NEW.is_active = true AND (
    NEW.days_of_week IS DISTINCT FROM OLD.days_of_week OR
    NEW.specific_date IS DISTINCT FROM OLD.specific_date OR
    NEW.time_of_day IS DISTINCT FROM OLD.time_of_day
  ) THEN
    -- Eliminar instancias futuras pendientes
    DELETE FROM task_instances
    WHERE task_schedule_id = NEW.id
    AND due_date >= CURRENT_DATE
    AND status = 'pending';
    
    -- Regenerar
    PERFORM generate_instances_for_schedule(NEW.id, 7);
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER trigger_schedule_updated
  AFTER UPDATE ON task_schedules
  FOR EACH ROW
  EXECUTE FUNCTION on_schedule_updated();

-- Trigger: Actualizar puntos al completar tarea
CREATE TRIGGER trigger_update_points
  BEFORE UPDATE ON task_instances
  FOR EACH ROW
  EXECUTE FUNCTION update_kid_points();

-- Trigger: Actualizar timestamp de updated_at
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_profiles_updated_at
  BEFORE UPDATE ON profiles
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER trigger_task_templates_updated_at
  BEFORE UPDATE ON task_templates
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER trigger_task_schedules_updated_at
  BEFORE UPDATE ON task_schedules
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER trigger_kid_points_updated_at
  BEFORE UPDATE ON kid_points
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at();

-- ============================================
-- CRON JOBS
-- ============================================

-- Cron Job 1: Generar instancias diarias (cada día a medianoche UTC)
SELECT cron.schedule(
  'generate-daily-tasks',
  '0 0 * * *',
  $$SELECT generate_all_task_instances();$$
);

-- Cron Job 2: Limpiar instancias antiguas (primer día del mes a las 2am UTC)
SELECT cron.schedule(
  'cleanup-old-tasks',
  '0 2 1 * *',
  $$SELECT cleanup_old_instances();$$
);

-- ============================================
-- FUNCIONES ÚTILES PARA CONSULTAS
-- ============================================

-- Ver todos los schedules activos de un padre
CREATE OR REPLACE FUNCTION get_parent_schedules(p_parent_id UUID)
RETURNS TABLE (
  schedule_id UUID,
  kid_name TEXT,
  task_title TEXT,
  days_of_week INT[],
  time_of_day TEXT,
  specific_date DATE,
  points INT
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    ts.id,
    k.name,
    tt.title,
    ts.days_of_week,
    ts.time_of_day,
    ts.specific_date,
    tt.points
  FROM task_schedules ts
  JOIN kids k ON k.id = ts.kid_id
  JOIN task_templates tt ON tt.id = ts.task_template_id
  WHERE k.parent_id = p_parent_id AND ts.is_active = true
  ORDER BY k.order_index, k.name, tt.title;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Ver tareas de hoy para un padre
CREATE OR REPLACE FUNCTION get_today_tasks(p_parent_id UUID)
RETURNS TABLE (
  instance_id UUID,
  kid_name TEXT,
  kid_color TEXT,
  task_title TEXT,
  task_description TEXT,
  time_of_day TEXT,
  status TEXT,
  points INT,
  completed_at TIMESTAMPTZ
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    ti.id,
    k.name,
    k.color,
    tt.title,
    tt.description,
    ti.time_of_day,
    ti.status,
    tt.points,
    ti.completed_at
  FROM task_instances ti
  JOIN kids k ON k.id = ti.kid_id
  JOIN task_schedules ts ON ts.id = ti.task_schedule_id
  JOIN task_templates tt ON tt.id = ts.task_template_id
  WHERE k.parent_id = p_parent_id 
  AND ti.due_date = CURRENT_DATE
  ORDER BY 
    CASE ti.time_of_day
      WHEN 'morning' THEN 1
      WHEN 'afternoon' THEN 2
      WHEN 'evening' THEN 3
      WHEN 'night' THEN 4
    END,
    k.order_index,
    k.name;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Ver puntos de los niños de un padre
CREATE OR REPLACE FUNCTION get_kids_points(p_parent_id UUID)
RETURNS TABLE (
  kid_id UUID,
  kid_name TEXT,
  kid_avatar TEXT,
  kid_color TEXT,
  total_points INT,
  tasks_completed_today INT,
  tasks_pending_today INT
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    k.id,
    k.name,
    k.avatar_url,
    k.color,
    COALESCE(kp.total_points, 0) as total_points,
    (
      SELECT COUNT(*)::INT
      FROM task_instances ti
      WHERE ti.kid_id = k.id
      AND ti.status = 'completed'
      AND ti.due_date = CURRENT_DATE
    ) as tasks_completed_today,
    (
      SELECT COUNT(*)::INT
      FROM task_instances ti
      WHERE ti.kid_id = k.id
      AND ti.status = 'pending'
      AND ti.due_date = CURRENT_DATE
    ) as tasks_pending_today
  FROM kids k
  LEFT JOIN kid_points kp ON kp.kid_id = k.id
  WHERE k.parent_id = p_parent_id
  ORDER BY k.order_index, k.name;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Obtener estadísticas semanales de un niño
CREATE OR REPLACE FUNCTION get_kid_weekly_stats(p_kid_id UUID)
RETURNS TABLE (
  total_tasks INT,
  completed_tasks INT,
  completion_rate NUMERIC,
  points_earned INT
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    COUNT(*)::INT as total_tasks,
    COUNT(*) FILTER (WHERE ti.status = 'completed')::INT as completed_tasks,
    ROUND(
      (COUNT(*) FILTER (WHERE ti.status = 'completed')::NUMERIC / 
       NULLIF(COUNT(*)::NUMERIC, 0)) * 100, 
      2
    ) as completion_rate,
    COALESCE(SUM(tt.points) FILTER (WHERE ti.status = 'completed'), 0)::INT as points_earned
  FROM task_instances ti
  JOIN task_schedules ts ON ts.id = ti.task_schedule_id
  JOIN task_templates tt ON tt.id = ts.task_template_id
  WHERE ti.kid_id = p_kid_id
  AND ti.due_date >= CURRENT_DATE - INTERVAL '7 days'
  AND ti.due_date <= CURRENT_DATE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
