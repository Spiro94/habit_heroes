// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodayTask _$TodayTaskFromJson(Map<String, dynamic> json) => TodayTask(
  instanceId: json['instance_id'] as String,
  kidName: json['kid_name'] as String,
  taskTitle: json['task_title'] as String,
  timeOfDay: json['time_of_day'] as String,
  status: json['status'] as String,
  points: (json['points'] as num).toInt(),
  kidColor: json['kid_color'] as String?,
  taskDescription: json['task_description'] as String?,
  completedAt: json['completed_at'] == null
      ? null
      : DateTime.parse(json['completed_at'] as String),
);

Map<String, dynamic> _$TodayTaskToJson(TodayTask instance) => <String, dynamic>{
  'instance_id': instance.instanceId,
  'kid_name': instance.kidName,
  'kid_color': instance.kidColor,
  'task_title': instance.taskTitle,
  'task_description': instance.taskDescription,
  'time_of_day': instance.timeOfDay,
  'status': instance.status,
  'points': instance.points,
  'completed_at': instance.completedAt?.toIso8601String(),
};
