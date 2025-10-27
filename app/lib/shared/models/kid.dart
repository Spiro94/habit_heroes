import 'package:json_annotation/json_annotation.dart';

part 'kid.g.dart';

@JsonSerializable()
class Kid {
  final String id;
  @JsonKey(name: 'parent_id')
  final String parentId;
  final String name;
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  final String? color;
  @JsonKey(name: 'order_index')
  final int? orderIndex;
  @JsonKey(name: 'created_at')
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
