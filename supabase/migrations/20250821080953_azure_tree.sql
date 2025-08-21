/*
  # Create get_current_statistics function

  1. New Functions
    - `get_current_statistics()` - Returns statistics about users and complaints
      - `total_users` (bigint) - Total number of registered users
      - `total_complaints` (bigint) - Total number of complaints/messages
      - `pending_complaints` (bigint) - Number of pending complaints
      - `resolved_complaints` (bigint) - Number of resolved complaints
      - `last_updated` (timestamp) - Last complaint creation time

  2. Security
    - Grant execute permissions to authenticated and anonymous users
*/

CREATE OR REPLACE FUNCTION public.get_current_statistics()
RETURNS TABLE (
  total_users bigint,
  total_complaints bigint,
  pending_complaints bigint,
  resolved_complaints bigint,
  last_updated timestamp with time zone
)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT
    (SELECT count(*) FROM auth.users) AS total_users,
    (SELECT count(*) FROM public.complaints) AS total_complaints,
    (SELECT count(*) FROM public.complaints WHERE status = 'pending') AS pending_complaints,
    (SELECT count(*) FROM public.complaints WHERE status = 'resolved') AS resolved_complaints,
    (SELECT max(created_at) FROM public.complaints) AS last_updated;
END;
$$;

-- Grant execute permissions
GRANT EXECUTE ON FUNCTION public.get_current_statistics() TO authenticated;
GRANT EXECUTE ON FUNCTION public.get_current_statistics() TO anon;