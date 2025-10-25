// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_completion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskCompletion _$TaskCompletionFromJson(Map<String, dynamic> json) =>
    TaskCompletion(
      id: json['id'] as String,
      taskId: json['taskId'] as String,
      kidId: json['kidId'] as String,
      completedAt: DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$TaskCompletionToJson(TaskCompletion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'taskId': instance.taskId,
      'kidId': instance.kidId,
      'completedAt': instance.completedAt.toIso8601String(),
    };
