import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../outside/repositories/app_user/repository.dart';
import '../../../outside/repositories/rewards/repository.dart';
import '../base.dart';
import 'events.dart';
import 'state.dart';

class ParentRewards_Bloc
    extends Bloc_Base<ParentRewards_Event, ParentRewards_State> {
  ParentRewards_Bloc({
    required AppUser_Repository appUserRepository,
    required Reward_Repository rewardRepository,
    required ParentRewards_State initialState,
  }) : _appUserRepository = appUserRepository,
       _rewardRepository = rewardRepository,
       super(initialState) {
    on<ParentRewards_Event_LoadRewards>(
      _onLoadRewards,
      transformer: sequential(),
    );
    on<ParentRewards_Event_AddReward>(_onAddReward, transformer: sequential());
    on<ParentRewards_Event_UpdateReward>(
      _onUpdateReward,
      transformer: sequential(),
    );
    on<ParentRewards_Event_DeleteReward>(
      _onDeleteReward,
      transformer: sequential(),
    );
  }

  // TODO: implement
  // ignore: unused_field
  final AppUser_Repository _appUserRepository;
  // TODO: implement
  // ignore: unused_field
  final Reward_Repository _rewardRepository;

  Future<void> _onLoadRewards(
    ParentRewards_Event_LoadRewards event,
    Emitter<ParentRewards_State> emit,
  ) async {
    emit(state.copyWith(status: ParentRewards_Status.loading));
    try {
      // TODO: Implement fetching rewards logic using _rewardRepository
      // For now, just simulate a delay
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: ParentRewards_Status.loaded, rewards: []));
    } catch (e, stackTrace) {
      log.warning('${event.runtimeType}: error', e, stackTrace);
      emit(
        state.copyWith(
          status: ParentRewards_Status.error,
          setErrorMessage: e.toString,
        ),
      );
    }
  }

  Future<void> _onAddReward(
    ParentRewards_Event_AddReward event,
    Emitter<ParentRewards_State> emit,
  ) async {
    // TODO: Implement add reward logic
  }

  Future<void> _onUpdateReward(
    ParentRewards_Event_UpdateReward event,
    Emitter<ParentRewards_State> emit,
  ) async {
    // TODO: Implement update reward logic
  }

  Future<void> _onDeleteReward(
    ParentRewards_Event_DeleteReward event,
    Emitter<ParentRewards_State> emit,
  ) async {
    // TODO: Implement delete reward logic
  }
}
