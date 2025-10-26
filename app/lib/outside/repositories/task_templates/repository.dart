import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/models/task_template.dart';
import '../base.dart';

abstract class TaskTemplate_Repository extends Repository_Base {
  Future<TaskTemplate> createTaskTemplate({required TaskTemplate template});

  Future<TaskTemplate?> getTaskTemplate({required String id});

  Future<List<TaskTemplate>> getTaskTemplates();

  Future<TaskTemplate> updateTaskTemplate({required TaskTemplate template});

  Future<void> deleteTaskTemplate({required String id});
}

class SupabaseTaskTemplate_Repository extends TaskTemplate_Repository {
  SupabaseTaskTemplate_Repository({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  @override
  Future<void> init() async {}

  @override
  Future<TaskTemplate> createTaskTemplate({
    required TaskTemplate template,
  }) async {
    log.info('createTaskTemplate');
    final response = await _supabaseClient
        .from('task_templates')
        .insert(template.toJson())
        .select()
        .single();
    return TaskTemplate.fromJson(response);
  }

  @override
  Future<TaskTemplate?> getTaskTemplate({required String id}) async {
    log.info('getTaskTemplate');
    final response = await _supabaseClient
        .from('task_templates')
        .select()
        .eq('id', id)
        .maybeSingle();
    if (response != null) return TaskTemplate.fromJson(response);
    return null;
  }

  @override
  Future<List<TaskTemplate>> getTaskTemplates() async {
    log.info('getTaskTemplates');
    // RLS policies automatically filter by parent_id = auth.uid()
    final response = await _supabaseClient
        .from('task_templates')
        .select()
        .order('created_at', ascending: false);

    return (response as List<dynamic>)
        .map((json) => TaskTemplate.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<TaskTemplate> updateTaskTemplate({
    required TaskTemplate template,
  }) async {
    log.info('updateTaskTemplate');
    final response = await _supabaseClient
        .from('task_templates')
        .update(template.toJson())
        .eq('id', template.id)
        .select()
        .single();
    return TaskTemplate.fromJson(response);
  }

  @override
  Future<void> deleteTaskTemplate({required String id}) async {
    log.info('deleteTaskTemplate');
    await _supabaseClient.from('task_templates').delete().eq('id', id);
  }
}
