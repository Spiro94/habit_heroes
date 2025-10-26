import 'package:equatable/equatable.dart';

abstract class ParentTasks_Event extends Equatable {
  const ParentTasks_Event();

  @override
  List<Object?> get props => [];
}

class ParentTasks_Event_LoadTasks extends ParentTasks_Event {
  const ParentTasks_Event_LoadTasks();
}

/// Input for creating a task schedule
class TaskScheduleInput extends Equatable {
  const TaskScheduleInput({
    required this.kidId,
    this.daysOfWeek,
    this.timeOfDay,
    this.specificDate,
  });

  final String kidId;
  final List<int>? daysOfWeek;
  final String? timeOfDay;
  final DateTime? specificDate;

  @override
  List<Object?> get props => [kidId, daysOfWeek, timeOfDay, specificDate];
}

class ParentTasks_Event_AddTask extends ParentTasks_Event {
  const ParentTasks_Event_AddTask({
    required this.title,
    required this.points,
    required this.schedules,
    this.description,
  });

  final String title;
  final int points;
  final String? description;
  final List<TaskScheduleInput> schedules;

  @override
  List<Object?> get props => [
        title,
        points,
        description,
        schedules,
      ];
}

class ParentTasks_Event_UpdateTask extends ParentTasks_Event {
  const ParentTasks_Event_UpdateTask();
}

class ParentTasks_Event_DeleteTask extends ParentTasks_Event {
  const ParentTasks_Event_DeleteTask();
}
