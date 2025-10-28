import 'package:equatable/equatable.dart';

abstract class KidsDashboard_Event extends Equatable {
  const KidsDashboard_Event();

  @override
  List<Object?> get props => [];
}

class KidsDashboard_Event_LoadData extends KidsDashboard_Event {
  const KidsDashboard_Event_LoadData();
}

class KidsDashboard_Event_CompleteTask extends KidsDashboard_Event {
  const KidsDashboard_Event_CompleteTask({required this.instanceId});

  final String instanceId;

  @override
  List<Object?> get props => [instanceId];
}

class KidsDashboard_Event_SkipTask extends KidsDashboard_Event {
  const KidsDashboard_Event_SkipTask({required this.instanceId});

  final String instanceId;

  @override
  List<Object?> get props => [instanceId];
}

class KidsDashboard_Event_RefreshData extends KidsDashboard_Event {
  const KidsDashboard_Event_RefreshData();
}
