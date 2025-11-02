import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'enums/part_of_day.dart';

part 'task_schedule.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TaskSchedule extends Equatable {
  const TaskSchedule({
    required this.id,
    required this.taskTemplateId,
    required this.kidId,
    this.daysOfWeek,
    this.timeOfDay,
    this.specificTime,
    this.specificDate,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  @JsonKey(includeToJson: false)
  final String id;
  final String taskTemplateId;
  final String kidId;
  final List<int>?
  daysOfWeek; // [0=Sun, 1=Mon, 2=Tue, 3=Wed, 4=Thu, 5=Fri, 6=Sat]
  final PartOfDay? timeOfDay;
  @JsonKey(fromJson: _timeOfDayFromJson, toJson: _timeOfDayToJson)
  final TimeOfDay? specificTime;
  final DateTime? specificDate;
  final bool isActive;
  @JsonKey(includeToJson: false)
  final DateTime? createdAt;
  @JsonKey(includeToJson: false)
  final DateTime? updatedAt;

  factory TaskSchedule.fromJson(Map<String, dynamic> json) =>
      _$TaskScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$TaskScheduleToJson(this);

  @override
  List<Object?> get props => [
    id,
    taskTemplateId,
    kidId,
    daysOfWeek,
    timeOfDay,
    specificTime,
    specificDate,
    isActive,
    createdAt,
    updatedAt,
  ];
}

// Helper functions for TimeOfDay JSON serialization
TimeOfDay? _timeOfDayFromJson(String? time) {
  if (time == null) return null;
  final parts = time.split(':');
  if (parts.length != 2) return null;
  return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
}

String? _timeOfDayToJson(TimeOfDay? time) {
  if (time == null) return null;
  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}
