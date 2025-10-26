CREATE TYPE task_part_of_day AS ENUM ('morning', 'afternoon', 'evening', 'night');

ALTER TABLE tasks
ADD COLUMN family_id UUID REFERENCES families(id) ON DELETE CASCADE,
ADD COLUMN due_date DATE,
ADD COLUMN is_repetitive BOOLEAN DEFAULT FALSE,
ADD COLUMN due_days_of_week SMALLINT[], -- e.g., [0, 1, 2, 3, 4, 5, 6] for Sun-Sat
ADD COLUMN part_of_day task_part_of_day;

-- Check constraint for the days of the week array
CREATE OR REPLACE FUNCTION public.check_array_days_of_week(days SMALLINT[])
RETURNS BOOLEAN
LANGUAGE plpgsql
IMMUTABLE -- This tells PostgreSQL it's safe to use in a constraint
AS $$
DECLARE
    day SMALLINT;
BEGIN
    -- Allow NULL arrays (matches our original logic)
    IF days IS NULL THEN
        RETURN TRUE;
    END IF;

    -- Check each element
    -- This loop won't run if the array is empty, correctly returning TRUE
    FOREACH day IN ARRAY days
    LOOP
        IF day < 0 OR day > 6 THEN
            RETURN FALSE; -- Found a bad value
        END IF;
    END LOOP;

    -- All elements were valid
    RETURN TRUE;
END;
$$;

-- Add the new, valid constraint using the function
ALTER TABLE tasks
ADD CONSTRAINT check_due_days_of_week
CHECK ( public.check_array_days_of_week(due_days_of_week) );


ALTER TABLE rewards
ADD COLUMN family_id UUID REFERENCES families(id) ON DELETE CASCADE;

-- Drop old policies
DROP POLICY "Users can view tasks for their family members" ON tasks;
DROP POLICY "Users can insert tasks for their family members" ON tasks;
DROP POLICY "Users can update tasks for their family members" ON tasks;
DROP POLICY "Users can delete tasks for their family members" ON tasks;

-- Create new policies
CREATE POLICY "Users can view tasks in their family" ON tasks
    FOR SELECT USING (
        family_id IN (
            SELECT family_id FROM family_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can insert tasks in their family" ON tasks
    FOR INSERT WITH CHECK (
        family_id IN (
            SELECT family_id FROM family_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can update tasks in their family" ON tasks
    FOR UPDATE USING (
        family_id IN (
            SELECT family_id FROM family_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can delete tasks in their family" ON tasks
    FOR DELETE USING (
        family_id IN (
            SELECT family_id FROM family_members
            WHERE user_id = auth.uid()
        )
    );

-- Drop old policies
DROP POLICY "Users can view rewards for their family members" ON rewards;
DROP POLICY "Users can insert rewards for their family members" ON rewards;
DROP POLICY "Users can update rewards for their family members" ON rewards;
DROP POLICY "Users can delete rewards for their family members" ON rewards;

-- Create new policies
CREATE POLICY "Users can view rewards in their family" ON rewards
    FOR SELECT USING (
        family_id IN (
            SELECT family_id FROM family_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can insert rewards in their family" ON rewards
    FOR INSERT WITH CHECK (
        family_id IN (
            SELECT family_id FROM family_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can update rewards in their family" ON rewards
    FOR UPDATE USING (
        family_id IN (
            SELECT family_id FROM family_members
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Users can delete rewards in their family" ON rewards
    FOR DELETE USING (
        family_id IN (
            SELECT family_id FROM family_members
            WHERE user_id = auth.uid()
        )
    );