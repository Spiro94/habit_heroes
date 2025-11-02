-- ============================================
-- FIX POINT DEDUCTION ON TASK UN-COMPLETION
-- ============================================
-- Problem: When a kid un-completes a task, points are not being subtracted
-- Solution: Update the trigger function to handle both point addition AND subtraction

-- Drop and recreate the function with improved logic
CREATE OR REPLACE FUNCTION update_kid_points()
RETURNS TRIGGER AS $$
DECLARE
  task_points INT;
BEGIN
  -- Case 1: Task is being completed (add points)
  IF NEW.status = 'completed' AND (OLD.status IS NULL OR OLD.status != 'completed') THEN

    -- Get points from the task template
    SELECT tt.points INTO task_points
    FROM task_schedules ts
    JOIN task_templates tt ON tt.id = ts.task_template_id
    WHERE ts.id = NEW.task_schedule_id;

    -- Insert or update kid's total points (add points)
    INSERT INTO kid_points (kid_id, total_points, updated_at)
    VALUES (NEW.kid_id, COALESCE(task_points, 0), NOW())
    ON CONFLICT (kid_id)
    DO UPDATE SET
      total_points = kid_points.total_points + COALESCE(task_points, 0),
      updated_at = NOW();

    -- Set completed_at timestamp
    NEW.completed_at := NOW();

  -- Case 2: Task is being un-completed (subtract points)
  ELSIF OLD.status = 'completed' AND NEW.status != 'completed' THEN

    -- Get points from the task template
    SELECT tt.points INTO task_points
    FROM task_schedules ts
    JOIN task_templates tt ON tt.id = ts.task_template_id
    WHERE ts.id = NEW.task_schedule_id;

    -- Deduct points from kid's total (prevent negative points)
    UPDATE kid_points
    SET total_points = GREATEST(0, total_points - COALESCE(task_points, 0)),
        updated_at = NOW()
    WHERE kid_id = NEW.kid_id;

    -- Clear completed_at timestamp
    NEW.completed_at := NULL;

  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Note: The trigger already exists, no need to recreate it
-- CREATE TRIGGER trigger_update_points
--   BEFORE UPDATE ON task_instances
--   FOR EACH ROW
--   EXECUTE FUNCTION update_kid_points();
