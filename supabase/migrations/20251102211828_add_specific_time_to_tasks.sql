-- ============================================
-- ADD SPECIFIC TIME TO TASK SCHEDULES AND INSTANCES
-- ============================================

-- Add specific_time column to task_schedules
ALTER TABLE task_schedules
ADD COLUMN specific_time TIME;

-- Add specific_time column to task_instances
ALTER TABLE task_instances
ADD COLUMN specific_time TIME;

-- Update the time_of_day CHECK constraint to remove 'evening'
-- First drop the old constraint on task_schedules
ALTER TABLE task_schedules
DROP CONSTRAINT IF EXISTS task_schedules_time_of_day_check;

-- Add new constraint without 'evening'
ALTER TABLE task_schedules
ADD CONSTRAINT task_schedules_time_of_day_check
CHECK (time_of_day IN ('morning', 'afternoon', 'night'));

-- ============================================
-- UPDATE FUNCTION TO COPY SPECIFIC TIME
-- ============================================

-- Update generate_instances_for_schedule function to include specific_time
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
  -- Get the schedule
  SELECT
    ts.*,
    tt.title as task_title
  INTO schedule_record
  FROM task_schedules ts
  JOIN task_templates tt ON tt.id = ts.task_template_id
  WHERE ts.id = p_schedule_id AND ts.is_active = true;

  -- If not found or inactive, exit
  IF NOT FOUND THEN
    RETURN;
  END IF;

  -- Generate instances from TODAY until p_days_ahead days in the future
  FOR i IN 0..(p_days_ahead - 1) LOOP
    check_date := CURRENT_DATE + i;
    day_of_week := EXTRACT(DOW FROM check_date)::INT;

    -- Check if instance should be generated for this date
    IF (
      -- Case 1: It's a recurring task and matches the day of week
      (schedule_record.days_of_week IS NOT NULL
       AND schedule_record.days_of_week @> ARRAY[day_of_week])
      OR
      -- Case 2: It's a task with specific date
      (schedule_record.specific_date IS NOT NULL
       AND schedule_record.specific_date = check_date)
    ) THEN

      -- Insert only if it doesn't already exist
      INSERT INTO task_instances (
        task_schedule_id,
        kid_id,
        due_date,
        time_of_day,
        specific_time,
        status,
        created_at
      )
      VALUES (
        schedule_record.id,
        schedule_record.kid_id,
        check_date,
        COALESCE(schedule_record.time_of_day, 'morning'),
        schedule_record.specific_time,
        'pending',
        NOW()
      )
      ON CONFLICT (task_schedule_id, due_date)
      DO NOTHING;

    END IF;
  END LOOP;

  RAISE NOTICE 'Instances generated for schedule_id: %', p_schedule_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- UPDATE HELPER FUNCTIONS
-- ============================================

-- Drop and recreate functions with new signature
DROP FUNCTION IF EXISTS get_parent_schedules(UUID);
DROP FUNCTION IF EXISTS get_today_tasks(UUID);

-- Update get_parent_schedules to include specific_time
CREATE OR REPLACE FUNCTION get_parent_schedules(p_parent_id UUID)
RETURNS TABLE (
  schedule_id UUID,
  kid_name TEXT,
  task_title TEXT,
  days_of_week INT[],
  time_of_day TEXT,
  specific_time TIME,
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
    ts.specific_time,
    ts.specific_date,
    tt.points
  FROM task_schedules ts
  JOIN kids k ON k.id = ts.kid_id
  JOIN task_templates tt ON tt.id = ts.task_template_id
  WHERE k.parent_id = p_parent_id AND ts.is_active = true
  ORDER BY k.order_index, k.name, tt.title;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Update get_today_tasks to include specific_time
CREATE OR REPLACE FUNCTION get_today_tasks(p_parent_id UUID)
RETURNS TABLE (
  instance_id UUID,
  kid_name TEXT,
  kid_color TEXT,
  task_title TEXT,
  task_description TEXT,
  time_of_day TEXT,
  specific_time TIME,
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
    ti.specific_time,
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
      WHEN 'night' THEN 3
    END,
    ti.specific_time NULLS LAST,
    k.order_index,
    k.name;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
