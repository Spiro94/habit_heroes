import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reward.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Reward extends Equatable {
  const Reward({
    required this.id,
    required this.parentId,
    required this.name,
    required this.points,
    required this.createdAt,
    this.description,
    this.updatedAt,
  });

  @JsonKey(includeToJson: false)
  final String id;
  final String parentId;
  final String name;
  final String? description;
  final int points;
  @JsonKey(includeToJson: false)
  final DateTime createdAt;
  @JsonKey(includeToJson: false)
  final DateTime? updatedAt;

  factory Reward.fromJson(Map<String, dynamic> json) => _$RewardFromJson(json);
  Map<String, dynamic> toJson() => _$RewardToJson(this);

  @override
  List<Object?> get props => [
    id,
    parentId,
    name,
    description,
    points,
    createdAt,
    updatedAt,
  ];
}
