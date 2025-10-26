import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_instance.g.dart';

enum TaskStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('completed')
  completed,
  @JsonValue('skipped')
  skipped,
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TaskInstance extends Equatable {
  const TaskInstance({
    required this.id,
    required this.taskScheduleId,
    required this.kidId,
    required this.dueDate,
    required this.timeOfDay,
    this.status = TaskStatus.pending,
    this.completedAt,
    this.createdAt,
  });

  final String id;
  final String taskScheduleId;
  final String kidId;
  final DateTime dueDate;
  final String timeOfDay;
  final TaskStatus status;
  final DateTime? completedAt;
  final DateTime? createdAt;

  factory TaskInstance.fromJson(Map<String, dynamic> json) =>
      _$TaskInstanceFromJson(json);

  Map<String, dynamic> toJson() => _$TaskInstanceToJson(this);

  @override
  List<Object?> get props => [
        id,
        taskScheduleId,
        kidId,
        dueDate,
        timeOfDay,
        status,
        completedAt,
        createdAt,
      ];
}
