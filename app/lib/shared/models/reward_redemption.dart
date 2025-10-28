import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reward_redemption.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RewardRedemption extends Equatable {
  const RewardRedemption({
    required this.id,
    required this.kidId,
    required this.rewardId,
    required this.pointsCost,
    required this.redeemedAt,
    required this.createdAt,
    this.kidName,
    this.rewardName,
  });

  factory RewardRedemption.fromJson(Map<String, dynamic> json) =>
      _$RewardRedemptionFromJson(json);

  final String id;
  final String kidId;
  final String rewardId;
  final int pointsCost;
  final DateTime redeemedAt;
  final DateTime createdAt;
  final String? kidName;
  final String? rewardName;

  Map<String, dynamic> toJson() => _$RewardRedemptionToJson(this);

  @override
  List<Object?> get props => [
    id,
    kidId,
    rewardId,
    pointsCost,
    redeemedAt,
    createdAt,
    kidName,
    rewardName,
  ];
}
