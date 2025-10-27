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
  timeOfDay: $enumDecodeNullable(_$PartOfDayEnumMap, json['time_of_day']),
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
      'task_template_id': instance.taskTemplateId,
      'kid_id': instance.kidId,
      'days_of_week': instance.daysOfWeek,
      'time_of_day': _$PartOfDayEnumMap[instance.timeOfDay],
      'specific_date': instance.specificDate?.toIso8601String(),
      'is_active': instance.isActive,
    };

const _$PartOfDayEnumMap = {
  PartOfDay.morning: 'morning',
  PartOfDay.afternoon: 'afternoon',
  PartOfDay.night: 'night',
};
