-- ============================================
-- REWARDS TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS rewards (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  parent_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT,
  points INT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index for queries
CREATE INDEX IF NOT EXISTS idx_rewards_parent ON rewards(parent_id);

-- Enable RLS
ALTER TABLE rewards ENABLE ROW LEVEL SECURITY;

-- Policies for rewards
CREATE POLICY "Parents can view own rewards"
  ON rewards FOR SELECT
  USING (parent_id = auth.uid());

CREATE POLICY "Parents can insert own rewards"
  ON rewards FOR INSERT
  WITH CHECK (parent_id = auth.uid());

CREATE POLICY "Parents can update own rewards"
  ON rewards FOR UPDATE
  USING (parent_id = auth.uid())
  WITH CHECK (parent_id = auth.uid());

CREATE POLICY "Parents can delete own rewards"
  ON rewards FOR DELETE
  USING (parent_id = auth.uid());

-- ============================================
-- REWARD REDEMPTIONS TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS reward_redemptions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  kid_id UUID NOT NULL REFERENCES kids(id) ON DELETE CASCADE,
  reward_id UUID NOT NULL REFERENCES rewards(id) ON DELETE CASCADE,
  points_cost INT NOT NULL,
  redeemed_at TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index for queries
CREATE INDEX IF NOT EXISTS idx_reward_redemptions_kid ON reward_redemptions(kid_id);
CREATE INDEX IF NOT EXISTS idx_reward_redemptions_reward ON reward_redemptions(reward_id);

-- Enable RLS
ALTER TABLE reward_redemptions ENABLE ROW LEVEL SECURITY;

-- Policies for reward_redemptions
CREATE POLICY "Parents can view own kids redemptions"
  ON reward_redemptions FOR SELECT
  USING (
    kid_id IN (
      SELECT id FROM kids WHERE parent_id = auth.uid()
    )
  );

CREATE POLICY "System can insert redemptions"
  ON reward_redemptions FOR INSERT
  WITH CHECK (true); -- RPC function will handle authorization

-- ============================================
-- FUNCTION: Redeem Reward
-- ============================================

CREATE OR REPLACE FUNCTION redeem_reward(
  p_kid_id UUID,
  p_reward_id UUID,
  p_points_cost INT
)
RETURNS void AS $$
DECLARE
  v_current_points INT;
  v_kid_parent_id UUID;
  v_reward_parent_id UUID;
BEGIN
  -- Get kid's parent_id to verify authorization
  SELECT parent_id INTO v_kid_parent_id
  FROM kids
  WHERE id = p_kid_id;

  IF v_kid_parent_id IS NULL THEN
    RAISE EXCEPTION 'Kid not found';
  END IF;

  -- Verify the requesting user is the parent of this kid
  IF v_kid_parent_id != auth.uid() THEN
    RAISE EXCEPTION 'Unauthorized: You do not have permission to redeem rewards for this kid';
  END IF;

  -- Get reward's parent_id to verify it belongs to this parent
  SELECT parent_id INTO v_reward_parent_id
  FROM rewards
  WHERE id = p_reward_id;

  IF v_reward_parent_id IS NULL THEN
    RAISE EXCEPTION 'Reward not found';
  END IF;

  -- Verify the reward belongs to this parent
  IF v_reward_parent_id != auth.uid() THEN
    RAISE EXCEPTION 'Unauthorized: Reward does not belong to you';
  END IF;

  -- Get current points
  SELECT total_points INTO v_current_points
  FROM kid_points
  WHERE kid_id = p_kid_id;

  IF v_current_points IS NULL THEN
    RAISE EXCEPTION 'Kid points record not found';
  END IF;

  -- Check if kid has enough points
  IF v_current_points < p_points_cost THEN
    RAISE EXCEPTION 'Insufficient points: Kid has % points, but reward costs % points',
                    v_current_points, p_points_cost;
  END IF;

  -- Deduct points
  UPDATE kid_points
  SET total_points = total_points - p_points_cost,
      updated_at = NOW()
  WHERE kid_id = p_kid_id;

  -- Record the redemption
  INSERT INTO reward_redemptions (kid_id, reward_id, points_cost)
  VALUES (p_kid_id, p_reward_id, p_points_cost);

END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
