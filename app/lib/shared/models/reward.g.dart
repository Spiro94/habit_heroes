// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reward _$RewardFromJson(Map<String, dynamic> json) => Reward(
  id: json['id'] as String,
  parentId: json['parent_id'] as String,
  name: json['name'] as String,
  points: (json['points'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  description: json['description'] as String?,
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$RewardToJson(Reward instance) => <String, dynamic>{
  'id': instance.id,
  'parent_id': instance.parentId,
  'name': instance.name,
  'description': instance.description,
  'points': instance.points,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};
