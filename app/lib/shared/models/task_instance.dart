import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
    this.specificTime,
    this.status = TaskStatus.pending,
    this.completedAt,
    this.createdAt,
  });

  final String id;
  final String taskScheduleId;
  final String kidId;
  final DateTime dueDate;
  final String timeOfDay;
  @JsonKey(
    fromJson: _timeOfDayFromJson,
    toJson: _timeOfDayToJson,
  )
  final TimeOfDay? specificTime;
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
        specificTime,
        status,
        completedAt,
        createdAt,
      ];
}

// Helper functions for TimeOfDay JSON serialization
TimeOfDay? _timeOfDayFromJson(String? time) {
  if (time == null) return null;
  final parts = time.split(':');
  if (parts.length != 2) return null;
  return TimeOfDay(
    hour: int.parse(parts[0]),
    minute: int.parse(parts[1]),
  );
}

String? _timeOfDayToJson(TimeOfDay? time) {
  if (time == null) return null;
  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}
