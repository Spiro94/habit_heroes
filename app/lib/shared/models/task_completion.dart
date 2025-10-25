import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_completion.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TaskCompletion extends Equatable {
  const TaskCompletion({
    required this.id,
    required this.taskId,
    required this.kidId,
    required this.completedAt,
  });

  factory TaskCompletion.fromJson(Map<String, dynamic> json) =>
      _$TaskCompletionFromJson(json);

  final String id;
  final String taskId;
  final String kidId;
  final DateTime completedAt;

  Map<String, dynamic> toJson() => _$TaskCompletionToJson(this);

  @override
  List<Object?> get props => [id, taskId, kidId, completedAt];
}
