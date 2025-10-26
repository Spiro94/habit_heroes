import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/models/task_instance.dart';
import '../base.dart';

abstract class TaskInstance_Repository extends Repository_Base {
  Future<TaskInstance?> getTaskInstance({required String id});

  Future<List<TaskInstance>> getTaskInstances({
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<List<TaskInstance>> getTaskInstancesForKid({
    required String kidId,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<List<TaskInstance>> getTodayTaskInstances();

  Future<TaskInstance> updateTaskInstance({required TaskInstance instance});

  Future<TaskInstance> completeTaskInstance({required String id});

  Future<TaskInstance> skipTaskInstance({required String id});
}

class SupabaseTaskInstance_Repository extends TaskInstance_Repository {
  SupabaseTaskInstance_Repository({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  @override
  Future<void> init() async {}

  @override
  Future<TaskInstance?> getTaskInstance({required String id}) async {
    log.info('getTaskInstance');
    final response = await _supabaseClient
        .from('task_instances')
        .select()
        .eq('id', id)
        .maybeSingle();
    if (response != null) return TaskInstance.fromJson(response);
    return null;
  }

  @override
  Future<List<TaskInstance>> getTaskInstances({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    log.info('getTaskInstances');
    var query = _supabaseClient.from('task_instances').select();

    if (startDate != null) {
      query = query.gte('due_date', startDate.toIso8601String());
    }
    if (endDate != null) {
      query = query.lte('due_date', endDate.toIso8601String());
    }

    final response = await query.order('due_date', ascending: true);

    return (response as List<dynamic>)
        .map((json) => TaskInstance.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<TaskInstance>> getTaskInstancesForKid({
    required String kidId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    log.info('getTaskInstancesForKid');
    var query =
        _supabaseClient.from('task_instances').select().eq('kid_id', kidId);

    if (startDate != null) {
      query = query.gte('due_date', startDate.toIso8601String());
    }
    if (endDate != null) {
      query = query.lte('due_date', endDate.toIso8601String());
    }

    final response = await query.order('due_date', ascending: true);

    return (response as List<dynamic>)
        .map((json) => TaskInstance.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<TaskInstance>> getTodayTaskInstances() async {
    log.info('getTodayTaskInstances');
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    final response = await _supabaseClient
        .from('task_instances')
        .select()
        .eq('due_date', todayDate.toIso8601String().split('T')[0])
        .order('time_of_day', ascending: true);

    return (response as List<dynamic>)
        .map((json) => TaskInstance.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<TaskInstance> updateTaskInstance({
    required TaskInstance instance,
  }) async {
    log.info('updateTaskInstance');
    final response = await _supabaseClient
        .from('task_instances')
        .update(instance.toJson())
        .eq('id', instance.id)
        .select()
        .single();
    return TaskInstance.fromJson(response);
  }

  @override
  Future<TaskInstance> completeTaskInstance({required String id}) async {
    log.info('completeTaskInstance');
    final response = await _supabaseClient
        .from('task_instances')
        .update({
          'status': 'completed',
          'completed_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id)
        .select()
        .single();
    return TaskInstance.fromJson(response);
  }

  @override
  Future<TaskInstance> skipTaskInstance({required String id}) async {
    log.info('skipTaskInstance');
    final response = await _supabaseClient
        .from('task_instances')
        .update({'status': 'skipped'})
        .eq('id', id)
        .select()
        .single();
    return TaskInstance.fromJson(response);
  }
}
