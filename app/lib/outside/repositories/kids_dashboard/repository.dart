import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/models/kid_points.dart';
import '../../../shared/models/reward.dart';
import '../../../shared/models/today_task.dart';
import '../base.dart';

abstract class KidsDashboard_Repository extends Repository_Base {
  /// Get today's tasks for all kids
  /// Uses the get_today_tasks() database function
  Future<List<TodayTask>> getTodayTasks();

  /// Get points and stats for all kids
  /// Uses the get_kids_points() database function
  Future<List<KidPoints>> getKidsPoints();

  /// Get all available rewards for the family
  Future<List<Reward>> getRewards();

  /// Redeem a reward for a kid
  /// Deducts points from the kid and creates a redemption record
  Future<void> redeemReward({required String rewardId, required String kidId});

  /// Mark a task instance as completed
  Future<void> completeTask({required String instanceId});

  /// Mark a task instance as skipped
  Future<void> skipTask({required String instanceId});
}

class SupabaseKidsDashboard_Repository extends KidsDashboard_Repository {
  SupabaseKidsDashboard_Repository({required SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  @override
  Future<void> init() async {}

  @override
  Future<List<TodayTask>> getTodayTasks() async {
    log.info('getTodayTasks');

    // Get the current user's ID
    final userId = _supabaseClient.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    // Call the get_today_tasks() function
    final response = await _supabaseClient
        .rpc<List<dynamic>>('get_today_tasks', params: {'p_parent_id': userId});

    return response
        .map((json) => TodayTask.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<KidPoints>> getKidsPoints() async {
    log.info('getKidsPoints');

    // Get the current user's ID
    final userId = _supabaseClient.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    // Call the get_kids_points() function
    final response = await _supabaseClient
        .rpc<List<dynamic>>('get_kids_points', params: {'p_parent_id': userId});

    return response
        .map((json) => KidPoints.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> completeTask({required String instanceId}) async {
    log.info('completeTask: $instanceId');

    await _supabaseClient
        .from('task_instances')
        .update({'status': 'completed'})
        .eq('id', instanceId);
  }

  @override
  Future<void> skipTask({required String instanceId}) async {
    log.info('skipTask: $instanceId');

    await _supabaseClient
        .from('task_instances')
        .update({'status': 'skipped'})
        .eq('id', instanceId);
  }

  @override
  Future<List<Reward>> getRewards() async {
    log.info('getRewards');

    // Get the current user's ID (parent)
    final userId = _supabaseClient.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    // Get all rewards for this parent
    final response = await _supabaseClient
        .from('rewards')
        .select()
        .eq('parent_id', userId)
        .order('created_at', ascending: false);

    return response.map(Reward.fromJson).toList();
  }

  @override
  Future<void> redeemReward({
    required String rewardId,
    required String kidId,
  }) async {
    log.info('redeemReward: rewardId=$rewardId, kidId=$kidId');

    // Get the reward to know how many points it costs
    final rewardResponse = await _supabaseClient
        .from('rewards')
        .select()
        .eq('id', rewardId)
        .single();

    final reward = Reward.fromJson(rewardResponse);

    // Deduct points from the kid
    await _supabaseClient.rpc<void>(
      'redeem_reward',
      params: {
        'p_kid_id': kidId,
        'p_reward_id': rewardId,
        'p_points_cost': reward.points,
      },
    );
  }
}
