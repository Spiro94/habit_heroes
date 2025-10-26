import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/models/task_schedule.dart';
import '../base.dart';

abstract class TaskSchedule_Repository extends Repository_Base {
  Future<TaskSchedule> createTaskSchedule({required TaskSchedule schedule});

  Future<TaskSchedule?> getTaskSchedule({required String id});

  Future<List<TaskSchedule>> getTaskSchedules();

  Future<List<TaskSchedule>> getTaskSchedulesForKid({required String kidId});

  Future<TaskSchedule> updateTaskSchedule({required TaskSchedule schedule});

  Future<void> deleteTaskSchedule({required String id});
}

class SupabaseTaskSchedule_Repository extends TaskSchedule_Repository {
  SupabaseTaskSchedule_Repository({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  @override
  Future<void> init() async {}

  @override
  Future<TaskSchedule> createTaskSchedule({
    required TaskSchedule schedule,
  }) async {
    log.info('createTaskSchedule');
    final response = await _supabaseClient
        .from('task_schedules')
        .insert(schedule.toJson())
        .select()
        .single();
    return TaskSchedule.fromJson(response);
  }

  @override
  Future<TaskSchedule?> getTaskSchedule({required String id}) async {
    log.info('getTaskSchedule');
    final response = await _supabaseClient
        .from('task_schedules')
        .select()
        .eq('id', id)
        .maybeSingle();
    if (response != null) return TaskSchedule.fromJson(response);
    return null;
  }

  @override
  Future<List<TaskSchedule>> getTaskSchedules() async {
    log.info('getTaskSchedules');
    // RLS policies automatically filter by kids with parent_id = auth.uid()
    final response = await _supabaseClient
        .from('task_schedules')
        .select()
        .eq('is_active', true)
        .order('created_at', ascending: false);

    return (response as List<dynamic>)
        .map((json) => TaskSchedule.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<TaskSchedule>> getTaskSchedulesForKid({
    required String kidId,
  }) async {
    log.info('getTaskSchedulesForKid');
    final response = await _supabaseClient
        .from('task_schedules')
        .select()
        .eq('kid_id', kidId)
        .eq('is_active', true)
        .order('created_at', ascending: false);

    return (response as List<dynamic>)
        .map((json) => TaskSchedule.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<TaskSchedule> updateTaskSchedule({
    required TaskSchedule schedule,
  }) async {
    log.info('updateTaskSchedule');
    final response = await _supabaseClient
        .from('task_schedules')
        .update(schedule.toJson())
        .eq('id', schedule.id)
        .select()
        .single();
    return TaskSchedule.fromJson(response);
  }

  @override
  Future<void> deleteTaskSchedule({required String id}) async {
    log.info('deleteTaskSchedule');
    await _supabaseClient.from('task_schedules').delete().eq('id', id);
  }
}
