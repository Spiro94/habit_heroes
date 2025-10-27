import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_template.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TaskTemplate extends Equatable {
  const TaskTemplate({
    required this.id,
    required this.parentId,
    required this.title,
    this.description,
    this.points = 0,
    this.createdAt,
    this.updatedAt,
  });

  @JsonKey(includeToJson: false)
  final String id;
  final String parentId;
  final String title;
  final String? description;
  final int points;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory TaskTemplate.fromJson(Map<String, dynamic> json) =>
      _$TaskTemplateFromJson(json);

  Map<String, dynamic> toJson() => _$TaskTemplateToJson(this);

  @override
  List<Object?> get props =>
      [id, parentId, title, description, points, createdAt, updatedAt];
}
