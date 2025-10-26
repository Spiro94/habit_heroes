CREATE OR REPLACE FUNCTION get_my_family_members()
RETURNS TABLE(
    user_id UUID,
    display_name TEXT,
    role app_user_role,
    family_id UUID
)
LANGUAGE SQL
SECURITY DEFINER
-- We must set the search_path to prevent security/hijacking issues
SET search_path = public, pg_temp
AS $$
    SELECT
        au.id AS user_id,
        au.display_name,
        fm.role,
        fm.family_id
    FROM
        app_users au
    JOIN
        family_members fm ON au.id = fm.user_id
    WHERE
       fm.family_id in (SELECT family_id FROM family_members WHERE user_id = auth.uid())
    ORDER BY
        fm.family_id,
        fm.role,
        au.display_name;
$$;