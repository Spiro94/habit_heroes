// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskTemplate _$TaskTemplateFromJson(Map<String, dynamic> json) => TaskTemplate(
  id: json['id'] as String,
  parentId: json['parent_id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  points: (json['points'] as num?)?.toInt() ?? 0,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$TaskTemplateToJson(TaskTemplate instance) =>
    <String, dynamic>{
      'parent_id': instance.parentId,
      'title': instance.title,
      'description': instance.description,
      'points': instance.points,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
