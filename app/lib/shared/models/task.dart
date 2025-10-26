import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'enums/part_of_day.dart';

part 'task.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Task extends Equatable {
  const Task({
    required this.id,
    required this.familyId,
    required this.title,
    required this.points,
    required this.partOfDay,
    required this.isRepetitive,
    required this.dueDaysOfWeek,
    required this.createdAt,
    required this.assigneeId,
    this.dueDate,
    this.description,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  final String id;
  final String familyId;
  final String title;
  final String? description;
  final int points;
  final PartOfDay partOfDay;
  final bool isRepetitive;
  final List<int> dueDaysOfWeek;
  final String assigneeId;
  final DateTime? dueDate;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  @override
  List<Object?> get props => [
    id,
    familyId,
    title,
    description,
    points,
    partOfDay,
    isRepetitive,
    dueDaysOfWeek,
    createdAt,
    assigneeId,
    dueDate,
  ];
}
