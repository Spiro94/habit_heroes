import 'package:equatable/equatable.dart';

abstract class ParentTasks_Event extends Equatable {
  const ParentTasks_Event();

  @override
  List<Object?> get props => [];
}

class ParentTasks_Event_LoadTasks extends ParentTasks_Event {
  const ParentTasks_Event_LoadTasks();
}

class ParentTasks_Event_AddTask extends ParentTasks_Event {
  const ParentTasks_Event_AddTask();
}

class ParentTasks_Event_UpdateTask extends ParentTasks_Event {
  const ParentTasks_Event_UpdateTask();
}

class ParentTasks_Event_DeleteTask extends ParentTasks_Event {
  const ParentTasks_Event_DeleteTask();
}
