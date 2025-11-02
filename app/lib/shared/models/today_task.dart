import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
    this.specificTime,
    this.completedAt,
  });

  final String instanceId;
  final String kidName;
  final String? kidColor;
  final String taskTitle;
  final String? taskDescription;
  final String timeOfDay;
  @JsonKey(fromJson: _timeOfDayFromJson, toJson: _timeOfDayToJson)
  final TimeOfDay? specificTime;
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
    specificTime,
    status,
    points,
    completedAt,
  ];
}

// Helper functions for TimeOfDay JSON serialization
TimeOfDay? _timeOfDayFromJson(String? time) {
  if (time == null) return null;
  final parts = time.split(':');
  if (parts.length < 2) return null;
  return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
}

String? _timeOfDayToJson(TimeOfDay? time) {
  if (time == null) return null;
  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}
