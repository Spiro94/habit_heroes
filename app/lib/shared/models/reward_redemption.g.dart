// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_redemption.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RewardRedemption _$RewardRedemptionFromJson(Map<String, dynamic> json) =>
    RewardRedemption(
      id: json['id'] as String,
      kidId: json['kid_id'] as String,
      rewardId: json['reward_id'] as String,
      pointsCost: (json['points_cost'] as num).toInt(),
      redeemedAt: DateTime.parse(json['redeemed_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      kidName: json['kid_name'] as String?,
      rewardName: json['reward_name'] as String?,
    );

Map<String, dynamic> _$RewardRedemptionToJson(RewardRedemption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kid_id': instance.kidId,
      'reward_id': instance.rewardId,
      'points_cost': instance.pointsCost,
      'redeemed_at': instance.redeemedAt.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'kid_name': instance.kidName,
      'reward_name': instance.rewardName,
    };
