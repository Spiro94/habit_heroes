
-- ============================================
-- DATOS DE EJEMPLO (OPCIONAL - COMENTADO)
-- ============================================

/*
-- Nota: Primero debes crear un usuario en Supabase Auth
-- Luego puedes usar su ID para estos ejemplos

-- Insertar niños de ejemplo (reemplazar 'parent-uuid' con ID real)
INSERT INTO kids (parent_id, name, color, order_index) VALUES
('parent-uuid', 'María', 'pink', 1),
('parent-uuid', 'Pedro', 'blue', 2),
('parent-uuid', 'Ana', 'green', 3);

-- Insertar plantillas de tareas
INSERT INTO task_templates (parent_id, title, description, points) VALUES
('parent-uuid', 'Lavar los platos', 'Lavar todos los platos después de la comida', 10),
('parent-uuid', 'Hacer la cama', 'Tender la cama al levantarse', 5),
('parent-uuid', 'Sacar la basura', 'Llevar la basura al contenedor', 8),
('parent-uuid', 'Hacer tareas escolares', 'Completar las tareas del colegio', 15),
('parent-uuid', 'Ordenar el cuarto', 'Recoger juguetes y ordenar', 10);

-- Insertar schedules de ejemplo
-- María: Lavar platos lunes y miércoles por la noche
INSERT INTO task_schedules (task_template_id, kid_id, days_of_week, time_of_day) 
VALUES (
  (SELECT id FROM task_templates WHERE title = 'Lavar los platos' LIMIT 1),
  (SELECT id FROM kids WHERE name = 'María' LIMIT 1),
  ARRAY[1,3],
  'night'
);

-- Pedro: Hacer la cama todos los días por la mañana
INSERT INTO task_schedules (task_template_id, kid_id, days_of_week, time_of_day) 
VALUES (
  (SELECT id FROM task_templates WHERE title = 'Hacer la cama' LIMIT 1),
  (SELECT id FROM kids WHERE name = 'Pedro' LIMIT 1),
  ARRAY[0,1,2,3,4,5,6],
  'morning'
);

-- Ana: Sacar basura jueves por la tarde
INSERT INTO task_schedules (task_template_id, kid_id, days_of_week, time_of_day) 
VALUES (
  (SELECT id FROM task_templates WHERE title = 'Sacar la basura' LIMIT 1),
  (SELECT id FROM kids WHERE name = 'Ana' LIMIT 1),
  ARRAY[4],
  'afternoon'
);
*/

-- ============================================
-- COMANDOS ÚTILES PARA ADMINISTRACIÓN
-- ============================================

-- Ver todos los cron jobs configurados
-- SELECT * FROM cron.job;

-- Ver historial de ejecuciones de cron jobs
-- SELECT * FROM cron.job_run_details ORDER BY start_time DESC LIMIT 10;

-- Generar manualmente instancias para todos los schedules
-- SELECT generate_all_task_instances();

-- Generar instancias para un schedule específico
-- SELECT generate_instances_for_schedule('schedule-uuid', 7);

-- Ver tareas de hoy para un padre
-- SELECT * FROM get_today_tasks('parent-uuid');

-- Ver puntos de los niños
-- SELECT * FROM get_kids_points('parent-uuid');

-- Ver estadísticas semanales de un niño
-- SELECT * FROM get_kid_weekly_stats('kid-uuid');

-- Limpiar instancias antiguas manualmente
-- SELECT cleanup_old_instances();

-- Verificar RLS está habilitado en todas las tablas
-- SELECT schemaname, tablename, rowsecurity 
-- FROM pg_tables 
-- WHERE schemaname = 'public';

-- Ver todas las policies de una tabla
-- SELECT * FROM pg_policies WHERE tablename = 'task_instances';