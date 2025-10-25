import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

enum TimeOfDayCategory { morning, afternoon, evening }

enum Repetition { daily, weekly }

@JsonSerializable(fieldRename: FieldRename.snake)
class Task extends Equatable {
  const Task({
    required this.id,
    required this.familyId,
    required this.title,
    required this.points,
    required this.timeOfDay,
    required this.repeat,
    required this.daysOfWeek,
    required this.createdAt,
    this.description,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  final String id;
  final String familyId;
  final String title;
  final String? description;
  final int points;
  final TimeOfDayCategory timeOfDay;
  final Repetition repeat;
  final List<int> daysOfWeek;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  @override
  List<Object?> get props => [
    id,
    familyId,
    title,
    description,
    points,
    timeOfDay,
    repeat,
    daysOfWeek,
    createdAt,
  ];
}
