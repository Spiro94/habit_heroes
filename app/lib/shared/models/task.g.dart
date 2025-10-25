// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
  id: json['id'] as String,
  familyId: json['family_id'] as String,
  title: json['title'] as String,
  points: (json['points'] as num).toInt(),
  timeOfDay: $enumDecode(_$TimeOfDayCategoryEnumMap, json['time_of_day']),
  repeat: $enumDecode(_$RepetitionEnumMap, json['repeat']),
  daysOfWeek: (json['days_of_week'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  createdAt: DateTime.parse(json['created_at'] as String),
  description: json['description'] as String?,
);

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
  'id': instance.id,
  'family_id': instance.familyId,
  'title': instance.title,
  'description': instance.description,
  'points': instance.points,
  'time_of_day': _$TimeOfDayCategoryEnumMap[instance.timeOfDay]!,
  'repeat': _$RepetitionEnumMap[instance.repeat]!,
  'days_of_week': instance.daysOfWeek,
  'created_at': instance.createdAt.toIso8601String(),
};

const _$TimeOfDayCategoryEnumMap = {
  TimeOfDayCategory.morning: 'morning',
  TimeOfDayCategory.afternoon: 'afternoon',
  TimeOfDayCategory.evening: 'evening',
};

const _$RepetitionEnumMap = {
  Repetition.daily: 'daily',
  Repetition.weekly: 'weekly',
};
