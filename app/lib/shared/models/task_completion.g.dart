// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_completion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskCompletion _$TaskCompletionFromJson(Map<String, dynamic> json) =>
    TaskCompletion(
      id: json['id'] as String,
      taskId: json['task_id'] as String,
      kidId: json['kid_id'] as String,
      completedAt: DateTime.parse(json['completed_at'] as String),
    );

Map<String, dynamic> _$TaskCompletionToJson(TaskCompletion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task_id': instance.taskId,
      'kid_id': instance.kidId,
      'completed_at': instance.completedAt.toIso8601String(),
    };
