import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_schedule.g.dart';

enum TimeOfDay {
  @JsonValue('morning')
  morning,
  @JsonValue('afternoon')
  afternoon,
  @JsonValue('evening')
  evening,
  @JsonValue('night')
  night,
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TaskSchedule extends Equatable {
  const TaskSchedule({
    required this.id,
    required this.taskTemplateId,
    required this.kidId,
    this.daysOfWeek,
    this.timeOfDay,
    this.specificDate,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String taskTemplateId;
  final String kidId;
  final List<int>? daysOfWeek; // [0=Sun, 1=Mon, 2=Tue, 3=Wed, 4=Thu, 5=Fri, 6=Sat]
  final TimeOfDay? timeOfDay;
  final DateTime? specificDate;
  final bool isActive;
  final DateTime? createdAt;
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
        specificDate,
        isActive,
        createdAt,
        updatedAt,
      ];
}
