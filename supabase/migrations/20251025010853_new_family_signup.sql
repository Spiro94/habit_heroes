-- Create the new, combined function
CREATE OR REPLACE FUNCTION public.complete_user_signup(
    p_display_name TEXT,
    p_user_role app_user_role,
    p_family_name TEXT DEFAULT NULL,
    p_family_code TEXT DEFAULT NULL
)
RETURNS UUID -- Returns the family_id (either new or joined)
LANGUAGE plpgsql
SECURITY DEFINER -- ESSENTIAL: This bypasses RLS for the transaction
SET search_path = public, auth, pg_temp
AS $$
DECLARE
    v_user_id UUID := auth.uid();
    v_family_id UUID;
BEGIN
    -- 1. Create the app_users profile. This happens in both flows.
    INSERT INTO public.app_users (id, role, display_name)
    VALUES (v_user_id, p_user_role, p_display_name);

    -- 2. Check if we are joining or creating a family
    IF p_family_code IS NOT NULL THEN
        -- ==== JOIN FAMILY FLOW ====

        -- Find the family_id from the code.
        -- Note: We use upper() to match the constraint in your table definition
        SELECT id INTO v_family_id
        FROM public.families
        WHERE family_code = upper(p_family_code);

        -- If no family is found, raise an error
        IF v_family_id IS NULL THEN
            RAISE EXCEPTION 'Invalid family code: %', p_family_code;
        END IF;

        -- Link the user to the existing family
        INSERT INTO public.family_members (family_id, user_id, role)
        VALUES (v_family_id, v_user_id, p_user_role);

    ELSIF p_family_name IS NOT NULL THEN
        -- ==== CREATE FAMILY FLOW ====

        -- Create the new family
        INSERT INTO public.families (name)
        VALUES (p_family_name)
        RETURNING id INTO v_family_id; -- Get the new family's ID

        -- Link the user to the new family
        INSERT INTO public.family_members (family_id, user_id, role)
        VALUES (v_family_id, v_user_id, p_user_role);
        
    ELSE
        -- Error: No code or name was provided
        RAISE EXCEPTION 'Must provide either a family_code to join or a family_name to create.';
    END IF;

    -- 3. Return the relevant family_id
    RETURN v_family_id;
END;
$$;

-- Grant authenticated users permission to call this function
GRANT EXECUTE
ON FUNCTION public.complete_user_signup(TEXT, app_user_role, TEXT, TEXT)
TO authenticated;