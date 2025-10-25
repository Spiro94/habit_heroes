// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reward _$RewardFromJson(Map<String, dynamic> json) => Reward(
  id: json['id'] as String,
  familyId: json['familyId'] as String,
  name: json['name'] as String,
  points: (json['points'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$RewardToJson(Reward instance) => <String, dynamic>{
  'id': instance.id,
  'familyId': instance.familyId,
  'name': instance.name,
  'points': instance.points,
  'createdAt': instance.createdAt.toIso8601String(),
};
