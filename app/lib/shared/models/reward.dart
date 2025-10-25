import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reward.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Reward extends Equatable {
  const Reward({
    required this.id,
    required this.familyId,
    required this.name,
    required this.points,
    required this.createdAt,
  });

  factory Reward.fromJson(Map<String, dynamic> json) => _$RewardFromJson(json);

  final String id;
  final String familyId;
  final String name;
  final int points;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => _$RewardToJson(this);

  @override
  List<Object?> get props => [id, familyId, name, points, createdAt];
}
