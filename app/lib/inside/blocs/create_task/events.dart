import '../../../shared/models/enums/days_of_week.dart';
import '../../../shared/models/enums/part_of_day.dart';

abstract class CreateTask_Event {}

class CreateTask_Event_LoadKids extends CreateTask_Event {}

class CreateTask_Event_CreateTask extends CreateTask_Event {
  CreateTask_Event_CreateTask({
    required this.title,
    required this.assigneeId,
    required this.points,
    required this.isRepetitive,
    required this.daysOfWeek,
    required this.partsOfDay,
  });

  final String title;
  final String assigneeId;
  final int points;
  final bool isRepetitive;
  final List<DaysOfWeek> daysOfWeek;
  final List<PartOfDay> partsOfDay;
}
