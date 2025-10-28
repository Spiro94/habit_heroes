import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../outside/repositories/reward_redemptions/repository.dart';
import '../../../../../outside/repositories/rewards/repository.dart';
import '../../../../blocs/auth/bloc.dart';
import '../../../../blocs/parent_rewards/bloc.dart';
import '../../../../blocs/parent_rewards/events.dart';
import '../../../../blocs/parent_rewards/state.dart';

@RoutePage(name: 'ParentRewards_Routes')
class ParentRewards_Router extends StatelessWidget {
  const ParentRewards_Router({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = context.read<Auth_Bloc>().state.appUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    return BlocProvider(
      create: (context) => ParentRewards_Bloc(
        userId: userId,
        rewardRepository: context.read<Reward_Repository>(),
        redemptionRepository: context.read<RewardRedemption_Repository>(),
        initialState: ParentRewards_State.initial(),
      )..add(const ParentRewards_Event_LoadRewards())
        ..add(const ParentRewards_Event_LoadRedemptions()),
      child: const AutoRouter(),
    );
  }
}
