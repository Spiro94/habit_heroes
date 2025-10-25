// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reward _$RewardFromJson(Map<String, dynamic> json) => Reward(
  id: json['id'] as String,
  familyId: json['family_id'] as String,
  name: json['name'] as String,
  points: (json['points'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$RewardToJson(Reward instance) => <String, dynamic>{
  'id': instance.id,
  'family_id': instance.familyId,
  'name': instance.name,
  'points': instance.points,
  'created_at': instance.createdAt.toIso8601String(),
};
