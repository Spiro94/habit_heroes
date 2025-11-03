
-- Migration: Create table for account deletion requests

CREATE TABLE account_deletion_requests (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    email text NOT NULL UNIQUE,
    requested_at timestamptz NOT NULL DEFAULT now(),
    processed_at timestamptz,
    status text NOT NULL DEFAULT 'pending',
    reason text,
    user_id uuid,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE SET NULL
);

CREATE INDEX idx_account_deletion_requests_status ON account_deletion_requests(status);


-- Enable Row Level Security
ALTER TABLE account_deletion_requests ENABLE ROW LEVEL SECURITY;

-- Policy: Allow anyone to insert deletion request (anonymous allowed)
CREATE POLICY "Allow insert deletion request" ON account_deletion_requests
  FOR INSERT
  WITH CHECK (true);

-- Policy: Allow anyone to select deletion requests (anonymous allowed)
CREATE POLICY "Allow select deletion request" ON account_deletion_requests
  FOR SELECT
  USING (true);

-- Policy: Allow users to update their own requests
CREATE POLICY "Allow update own deletion request" ON account_deletion_requests
  FOR UPDATE
  USING (auth.uid() = user_id);
