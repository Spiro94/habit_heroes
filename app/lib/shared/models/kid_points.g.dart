// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kid_points.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KidPoints _$KidPointsFromJson(Map<String, dynamic> json) => KidPoints(
  kidId: json['kid_id'] as String,
  kidName: json['kid_name'] as String,
  totalPoints: (json['total_points'] as num).toInt(),
  tasksCompletedToday: (json['tasks_completed_today'] as num).toInt(),
  tasksPendingToday: (json['tasks_pending_today'] as num).toInt(),
  kidAvatar: json['kid_avatar'] as String?,
  kidColor: json['kid_color'] as String?,
);

Map<String, dynamic> _$KidPointsToJson(KidPoints instance) => <String, dynamic>{
  'kid_id': instance.kidId,
  'kid_name': instance.kidName,
  'kid_avatar': instance.kidAvatar,
  'kid_color': instance.kidColor,
  'total_points': instance.totalPoints,
  'tasks_completed_today': instance.tasksCompletedToday,
  'tasks_pending_today': instance.tasksPendingToday,
};
