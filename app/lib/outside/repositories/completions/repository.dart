import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/models/task_completion.dart';
import '../base.dart';

abstract class TaskCompletion_Repository extends Repository_Base {
  Future<TaskCompletion> createTaskCompletion({
    required TaskCompletion taskCompletion,
  });

  Future<TaskCompletion?> getTaskCompletion({required String id});

  Future<TaskCompletion> updateTaskCompletion({
    required TaskCompletion taskCompletion,
  });

  Future<void> deleteTaskCompletion({required String id});

  Future<List<TaskCompletion>> getTaskCompletionsByTaskId({
    required String taskId,
  });

  Future<List<TaskCompletion>> getTaskCompletionsByAppUserId({
    required String appUserId,
  });
}

class SupabaseTaskCompletion_Repository extends TaskCompletion_Repository {
  SupabaseTaskCompletion_Repository({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  @override
  Future<void> init() async {}

  @override
  Future<TaskCompletion> createTaskCompletion({
    required TaskCompletion taskCompletion,
  }) async {
    log.info('createTaskCompletion');
    final response = await _supabaseClient
        .from('task_completions')
        .insert(taskCompletion.toJson())
        .select()
        .single();
    return TaskCompletion.fromJson(response);
  }

  @override
  Future<TaskCompletion?> getTaskCompletion({required String id}) async {
    log.info('getTaskCompletion');
    final response = await _supabaseClient
        .from('task_completions')
        .select()
        .eq('id', id)
        .single();
    return TaskCompletion.fromJson(response);
  }

  @override
  Future<TaskCompletion> updateTaskCompletion({
    required TaskCompletion taskCompletion,
  }) async {
    log.info('updateTaskCompletion');
    final response = await _supabaseClient
        .from('task_completions')
        .update(taskCompletion.toJson())
        .eq('id', taskCompletion.id)
        .select()
        .single();
    return TaskCompletion.fromJson(response);
  }

  @override
  Future<void> deleteTaskCompletion({required String id}) async {
    log.info('deleteTaskCompletion');
    await _supabaseClient.from('task_completions').delete().eq('id', id);
  }

  @override
  Future<List<TaskCompletion>> getTaskCompletionsByTaskId({
    required String taskId,
  }) async {
    log.info('getTaskCompletionsByTaskId');
    final response = await _supabaseClient
        .from('task_completions')
        .select()
        .eq('task_id', taskId);
    return response.map(TaskCompletion.fromJson).toList();
  }

  @override
  Future<List<TaskCompletion>> getTaskCompletionsByAppUserId({
    required String appUserId,
  }) async {
    log.info('getTaskCompletionsByAppUserId');
    final response = await _supabaseClient
        .from('task_completions')
        .select()
        .eq('app_user_id', appUserId);
    return response.map(TaskCompletion.fromJson).toList();
  }
}
