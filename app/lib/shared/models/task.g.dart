// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
  id: json['id'] as String,
  familyId: json['familyId'] as String,
  title: json['title'] as String,
  points: (json['points'] as num).toInt(),
  timeOfDay: $enumDecode(_$TimeOfDayCategoryEnumMap, json['timeOfDay']),
  repeat: $enumDecode(_$RepetitionEnumMap, json['repeat']),
  daysOfWeek: (json['daysOfWeek'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  description: json['description'] as String?,
);

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
  'id': instance.id,
  'familyId': instance.familyId,
  'title': instance.title,
  'description': instance.description,
  'points': instance.points,
  'timeOfDay': _$TimeOfDayCategoryEnumMap[instance.timeOfDay]!,
  'repeat': _$RepetitionEnumMap[instance.repeat]!,
  'daysOfWeek': instance.daysOfWeek,
  'createdAt': instance.createdAt.toIso8601String(),
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
