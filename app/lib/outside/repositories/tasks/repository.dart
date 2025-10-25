import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/models/task.dart';
import '../base.dart';

abstract class Task_Repository extends Repository_Base {
  Future<Task> createTask({required Task task});

  Future<Task?> getTask({required String id});

  Future<Task> updateTask({required Task task});

  Future<void> deleteTask({required String id});

  Future<List<Task>> getTasksByFamilyId({required String familyId});

  Future<List<Task>> getTasksByAssigneeId({required String assigneeId});
}

class SupabaseTask_Repository extends Task_Repository {
  SupabaseTask_Repository({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  @override
  Future<void> init() async {}

  @override
  Future<Task> createTask({required Task task}) async {
    log.info('createTask');
    final response =
        await _supabaseClient
            .from('tasks')
            .insert(task.toJson())
            .select()
            .single();
    return Task.fromJson(response);
  }

  @override
  Future<Task?> getTask({required String id}) async {
    log.info('getTask');
    final response =
        await _supabaseClient.from('tasks').select().eq('id', id).single();
    return Task.fromJson(response);
  }

  @override
  Future<Task> updateTask({required Task task}) async {
    log.info('updateTask');
    final response =
        await _supabaseClient
            .from('tasks')
            .update(task.toJson())
            .eq('id', task.id)
            .select()
            .single();
    return Task.fromJson(response);
  }

  @override
  Future<void> deleteTask({required String id}) async {
    log.info('deleteTask');
    await _supabaseClient.from('tasks').delete().eq('id', id);
  }

  @override
  Future<List<Task>> getTasksByFamilyId({required String familyId}) async {
    log.info('getTasksByFamilyId');
    final response = await _supabaseClient
        .from('tasks')
        .select()
        .eq('family_id', familyId);
    return response.map(Task.fromJson).toList();
  }

  @override
  Future<List<Task>> getTasksByAssigneeId({required String assigneeId}) async {
    log.info('getTasksByAssigneeId');
    final response = await _supabaseClient
        .from('tasks')
        .select()
        .eq('assignee_id', assigneeId);
    return response.map(Task.fromJson).toList();
  }
}
