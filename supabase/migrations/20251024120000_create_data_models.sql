
-- Create families table
CREATE TABLE families (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    name TEXT NOT NULL,
    family_code TEXT UNIQUE NOT NULL DEFAULT upper(substring(md5(random()::text) from 1 for 8))
);

-- Create app_users table
CREATE TYPE app_user_role AS ENUM ('parent', 'kid');

CREATE TABLE app_users (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    role app_user_role NOT NULL,
    display_name TEXT
);

-- Create family_members table
CREATE TABLE family_members (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    family_id UUID REFERENCES families(id) ON DELETE CASCADE,
    user_id UUID REFERENCES app_users(id) ON DELETE CASCADE,
    role app_user_role NOT NULL,
    UNIQUE(family_id, user_id)
);

-- Create tasks table
CREATE TABLE tasks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    title TEXT NOT NULL,
    description TEXT,
    points INTEGER NOT NULL,
    assignee_id UUID REFERENCES app_users(id),
    is_completed BOOLEAN DEFAULT FALSE
);

-- Create rewards table
CREATE TABLE rewards (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    title TEXT NOT NULL,
    description TEXT,
    cost INTEGER NOT NULL,
    assignee_id UUID REFERENCES app_users(id)
);

-- Create task_completions table
CREATE TABLE task_completions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    task_id UUID REFERENCES tasks(id),
    completed_by UUID REFERENCES app_users(id)
);

-- Enable RLS on all tables
ALTER TABLE families ENABLE ROW LEVEL SECURITY;
ALTER TABLE app_users ENABLE ROW LEVEL SECURITY;
ALTER TABLE family_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE rewards ENABLE ROW LEVEL SECURITY;
ALTER TABLE task_completions ENABLE ROW LEVEL SECURITY;

-- RLS Policies for families
CREATE POLICY "Users can view their own families" ON families
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM family_members fm
            WHERE fm.family_id = families.id AND fm.user_id = auth.uid()
        )
    );

CREATE POLICY "Users can insert families" ON families
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Users can update their own families" ON families
    FOR UPDATE USING (
        EXISTS (
            SELECT 1 FROM family_members fm
            WHERE fm.family_id = families.id AND fm.user_id = auth.uid()
        )
    );

CREATE POLICY "Users can delete their own families" ON families
    FOR DELETE USING (
        EXISTS (
            SELECT 1 FROM family_members fm
            WHERE fm.family_id = families.id AND fm.user_id = auth.uid()
        )
    );

-- RLS Policies for app_users
CREATE POLICY "Users can view their own profile" ON app_users
    FOR SELECT USING (id = auth.uid());

CREATE POLICY "Users can insert their own profile" ON app_users
    FOR INSERT WITH CHECK (id = auth.uid());

CREATE POLICY "Users can update their own profile" ON app_users
    FOR UPDATE USING (id = auth.uid());

CREATE POLICY "Users can delete their own profile" ON app_users
    FOR DELETE USING (id = auth.uid());


-- RLS Policies for tasks
CREATE POLICY "Users can view tasks for their family members" ON tasks
    FOR SELECT USING (
        assignee_id IN (
            SELECT user_id FROM family_members
            WHERE family_id IN (
                SELECT family_id FROM family_members
                WHERE user_id = auth.uid()
            )
        )
    );

CREATE POLICY "Users can insert tasks for their family members" ON tasks
    FOR INSERT WITH CHECK (
        assignee_id IN (
            SELECT user_id FROM family_members
            WHERE family_id IN (
                SELECT family_id FROM family_members
                WHERE user_id = auth.uid()
            )
        )
    );

CREATE POLICY "Users can update tasks for their family members" ON tasks
    FOR UPDATE USING (
        assignee_id IN (
            SELECT user_id FROM family_members
            WHERE family_id IN (
                SELECT family_id FROM family_members
                WHERE user_id = auth.uid()
            )
        )
    );

CREATE POLICY "Users can delete tasks for their family members" ON tasks
    FOR DELETE USING (
        assignee_id IN (
            SELECT user_id FROM family_members
            WHERE family_id IN (
                SELECT family_id FROM family_members
                WHERE user_id = auth.uid()
            )
        )
    );

-- RLS Policies for rewards
CREATE POLICY "Users can view rewards for their family members" ON rewards
    FOR SELECT USING (
        assignee_id IN (
            SELECT user_id FROM family_members
            WHERE family_id IN (
                SELECT family_id FROM family_members
                WHERE user_id = auth.uid()
            )
        )
    );

CREATE POLICY "Users can insert rewards for their family members" ON rewards
    FOR INSERT WITH CHECK (
        assignee_id IN (
            SELECT user_id FROM family_members
            WHERE family_id IN (
                SELECT family_id FROM family_members
                WHERE user_id = auth.uid()
            )
        )
    );

CREATE POLICY "Users can update rewards for their family members" ON rewards
    FOR UPDATE USING (
        assignee_id IN (
            SELECT user_id FROM family_members
            WHERE family_id IN (
                SELECT family_id FROM family_members
                WHERE user_id = auth.uid()
            )
        )
    );

CREATE POLICY "Users can delete rewards for their family members" ON rewards
    FOR DELETE USING (
        assignee_id IN (
            SELECT user_id FROM family_members
            WHERE family_id IN (
                SELECT family_id FROM family_members
                WHERE user_id = auth.uid()
            )
        )
    );

-- RLS Policies for task_completions
CREATE POLICY "Users can view task completions for their family members" ON task_completions
    FOR SELECT USING (
        completed_by IN (
            SELECT user_id FROM family_members
            WHERE family_id IN (
                SELECT family_id FROM family_members
                WHERE user_id = auth.uid()
            )
        )
    );

CREATE POLICY "Users can insert task completions for their family members" ON task_completions
    FOR INSERT WITH CHECK (
        completed_by IN (
            SELECT user_id FROM family_members
            WHERE family_id IN (
                SELECT family_id FROM family_members
                WHERE user_id = auth.uid()
            )
        )
    );

CREATE POLICY "Users can update task completions for their family members" ON task_completions
    FOR UPDATE USING (
        completed_by IN (
            SELECT user_id FROM family_members
            WHERE family_id IN (
                SELECT family_id FROM family_members
                WHERE user_id = auth.uid()
            )
        )
    );

CREATE POLICY "Users can delete task completions for their family members" ON task_completions
    FOR DELETE USING (
        completed_by IN (
            SELECT user_id FROM family_members
            WHERE family_id IN (
                SELECT family_id FROM family_members
                WHERE user_id = auth.uid()
            )
        )
    );

CREATE OR REPLACE FUNCTION public.is_user_in_family(
    p_user_id   UUID,
    p_family_id UUID
) RETURNS BOOLEAN
LANGUAGE SQL
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
    SELECT EXISTS (
        SELECT 1
          FROM family_members fm
         WHERE fm.user_id   = p_user_id
           AND fm.family_id = p_family_id
    );
$$;


REVOKE ALL ON FUNCTION public.is_user_in_family(UUID, UUID) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.is_user_in_family(UUID, UUID) TO PUBLIC;


-- RLS Policies for family_members
CREATE POLICY "Users can view family members in their families"
    ON public.family_members
    FOR SELECT
    USING (
        is_user_in_family(auth.uid(), family_members.family_id)
    );

CREATE POLICY "Users can insert family members in their families"
    ON public.family_members
    FOR INSERT
    WITH CHECK (
        is_user_in_family(auth.uid(), family_members.family_id)
    );

CREATE POLICY "Users can update family members in their families"
    ON public.family_members
    FOR UPDATE
    USING (
        is_user_in_family(auth.uid(), family_members.family_id)
    );

CREATE POLICY "Users can delete family members in their families"
    ON public.family_members
    FOR DELETE
    USING (
        is_user_in_family(auth.uid(), family_members.family_id)
    );
