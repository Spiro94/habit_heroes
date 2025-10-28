import 'package:equatable/equatable.dart';

import '../../../shared/models/reward.dart';

abstract class ParentRewards_Event extends Equatable {
  const ParentRewards_Event();

  @override
  List<Object?> get props => [];
}

class ParentRewards_Event_LoadRewards extends ParentRewards_Event {
  const ParentRewards_Event_LoadRewards();
}

class ParentRewards_Event_LoadRedemptions extends ParentRewards_Event {
  const ParentRewards_Event_LoadRedemptions();
}

class ParentRewards_Event_AddReward extends ParentRewards_Event {
  const ParentRewards_Event_AddReward({required this.reward});

  final Reward reward;

  @override
  List<Object?> get props => [reward];
}

class ParentRewards_Event_UpdateReward extends ParentRewards_Event {
  const ParentRewards_Event_UpdateReward({required this.reward});

  final Reward reward;

  @override
  List<Object?> get props => [reward];
}

class ParentRewards_Event_DeleteReward extends ParentRewards_Event {
  const ParentRewards_Event_DeleteReward({required this.rewardId});

  final String rewardId;

  @override
  List<Object?> get props => [rewardId];
}
