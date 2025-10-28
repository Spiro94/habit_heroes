import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'today_task.g.dart';

/// Represents a task instance for today's view
/// Maps to get_today_tasks() function result
@JsonSerializable(fieldRename: FieldRename.snake)
class TodayTask extends Equatable {
  const TodayTask({
    required this.instanceId,
    required this.kidName,
    required this.taskTitle,
    required this.timeOfDay,
    required this.status,
    required this.points,
    this.kidColor,
    this.taskDescription,
    this.completedAt,
  });

  final String instanceId;
  final String kidName;
  final String? kidColor;
  final String taskTitle;
  final String? taskDescription;
  final String timeOfDay;
  final String status; // 'pending', 'completed', 'skipped'
  final int points;
  final DateTime? completedAt;

  factory TodayTask.fromJson(Map<String, dynamic> json) =>
      _$TodayTaskFromJson(json);

  Map<String, dynamic> toJson() => _$TodayTaskToJson(this);

  @override
  List<Object?> get props => [
        instanceId,
        kidName,
        kidColor,
        taskTitle,
        taskDescription,
        timeOfDay,
        status,
        points,
        completedAt,
      ];
}
