// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_instance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskInstance _$TaskInstanceFromJson(Map<String, dynamic> json) => TaskInstance(
  id: json['id'] as String,
  taskScheduleId: json['task_schedule_id'] as String,
  kidId: json['kid_id'] as String,
  dueDate: DateTime.parse(json['due_date'] as String),
  timeOfDay: json['time_of_day'] as String,
  status:
      $enumDecodeNullable(_$TaskStatusEnumMap, json['status']) ??
      TaskStatus.pending,
  completedAt: json['completed_at'] == null
      ? null
      : DateTime.parse(json['completed_at'] as String),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$TaskInstanceToJson(TaskInstance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task_schedule_id': instance.taskScheduleId,
      'kid_id': instance.kidId,
      'due_date': instance.dueDate.toIso8601String(),
      'time_of_day': instance.timeOfDay,
      'status': _$TaskStatusEnumMap[instance.status]!,
      'completed_at': instance.completedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };

const _$TaskStatusEnumMap = {
  TaskStatus.pending: 'pending',
  TaskStatus.completed: 'completed',
  TaskStatus.skipped: 'skipped',
};
