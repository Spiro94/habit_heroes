import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'kid.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Kid extends Equatable {
  const Kid({
    required this.id,
    required this.parentId,
    required this.name,
    this.avatarUrl,
    this.color,
    this.orderIndex,
    this.createdAt,
  });

  final String id;
  final String parentId;
  final String name;
  final String? avatarUrl;
  final String? color;
  final int? orderIndex;
  final DateTime? createdAt;

  factory Kid.fromJson(Map<String, dynamic> json) => _$KidFromJson(json);

  Map<String, dynamic> toJson() => _$KidToJson(this);

  @override
  List<Object?> get props =>
      [id, parentId, name, avatarUrl, color, orderIndex, createdAt];
}
