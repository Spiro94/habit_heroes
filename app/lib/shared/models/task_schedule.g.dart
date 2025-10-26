// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskSchedule _$TaskScheduleFromJson(Map<String, dynamic> json) => TaskSchedule(
  id: json['id'] as String,
  taskTemplateId: json['task_template_id'] as String,
  kidId: json['kid_id'] as String,
  daysOfWeek: (json['days_of_week'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  timeOfDay: $enumDecodeNullable(_$TimeOfDayEnumMap, json['time_of_day']),
  specificDate: json['specific_date'] == null
      ? null
      : DateTime.parse(json['specific_date'] as String),
  isActive: json['is_active'] as bool? ?? true,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$TaskScheduleToJson(TaskSchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task_template_id': instance.taskTemplateId,
      'kid_id': instance.kidId,
      'days_of_week': instance.daysOfWeek,
      'time_of_day': _$TimeOfDayEnumMap[instance.timeOfDay],
      'specific_date': instance.specificDate?.toIso8601String(),
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$TimeOfDayEnumMap = {
  TimeOfDay.morning: 'morning',
  TimeOfDay.afternoon: 'afternoon',
  TimeOfDay.evening: 'evening',
  TimeOfDay.night: 'night',
};
