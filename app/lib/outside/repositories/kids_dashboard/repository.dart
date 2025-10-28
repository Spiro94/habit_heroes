import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/models/kid_points.dart';
import '../../../shared/models/today_task.dart';
import '../base.dart';

abstract class KidsDashboard_Repository extends Repository_Base {
  /// Get today's tasks for all kids
  /// Uses the get_today_tasks() database function
  Future<List<TodayTask>> getTodayTasks();

  /// Get points and stats for all kids
  /// Uses the get_kids_points() database function
  Future<List<KidPoints>> getKidsPoints();

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
}
