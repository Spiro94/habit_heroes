import 'package:json_annotation/json_annotation.dart';

part 'kid.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Kid {
  @JsonKey(includeToJson: false)
  final String id;
  final String parentId;
  final String name;
  final String? avatarUrl;
  final String? color;
  final int? orderIndex;
  final DateTime? createdAt;

  Kid({
    required this.id,
    required this.parentId,
    required this.name,
    this.avatarUrl,
    this.color,
    this.orderIndex,
    this.createdAt,
  });

  factory Kid.fromJson(Map<String, dynamic> json) => _$KidFromJson(json);

  Map<String, dynamic> toJson() => _$KidToJson(this);
}
