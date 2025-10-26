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
  partOfDay: $enumDecode(_$PartOfDayEnumMap, json['part_of_day']),
  isRepetitive: json['is_repetitive'] as bool,
  dueDaysOfWeek: (json['due_days_of_week'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  createdAt: DateTime.parse(json['created_at'] as String),
  assigneeId: json['assignee_id'] as String,
  dueDate: json['due_date'] == null
      ? null
      : DateTime.parse(json['due_date'] as String),
  description: json['description'] as String?,
);

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
  'id': instance.id,
  'family_id': instance.familyId,
  'title': instance.title,
  'description': instance.description,
  'points': instance.points,
  'part_of_day': _$PartOfDayEnumMap[instance.partOfDay]!,
  'is_repetitive': instance.isRepetitive,
  'due_days_of_week': instance.dueDaysOfWeek,
  'assignee_id': instance.assigneeId,
  'due_date': instance.dueDate?.toIso8601String(),
  'created_at': instance.createdAt.toIso8601String(),
};

const _$PartOfDayEnumMap = {
  PartOfDay.morning: 'morning',
  PartOfDay.afternoon: 'afternoon',
  PartOfDay.evening: 'evening',
};
