import 'package:equatable/equatable.dart';

abstract class ParentRewards_Event extends Equatable {
  const ParentRewards_Event();

  @override
  List<Object?> get props => [];
}

class ParentRewards_Event_LoadRewards extends ParentRewards_Event {
  const ParentRewards_Event_LoadRewards();
}

class ParentRewards_Event_AddReward extends ParentRewards_Event {
  const ParentRewards_Event_AddReward();
}

class ParentRewards_Event_UpdateReward extends ParentRewards_Event {
  const ParentRewards_Event_UpdateReward();
}

class ParentRewards_Event_DeleteReward extends ParentRewards_Event {
  const ParentRewards_Event_DeleteReward();
}
