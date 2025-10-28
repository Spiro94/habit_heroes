import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../outside/repositories/reward_redemptions/repository.dart';
import '../../../outside/repositories/rewards/repository.dart';
import '../../../shared/models/reward.dart';
import '../base.dart';
import 'events.dart';
import 'state.dart';

class ParentRewards_Bloc
    extends Bloc_Base<ParentRewards_Event, ParentRewards_State> {
  ParentRewards_Bloc({
    required String userId,
    required Reward_Repository rewardRepository,
    required RewardRedemption_Repository redemptionRepository,
    required ParentRewards_State initialState,
  }) : _userId = userId,
       _rewardRepository = rewardRepository,
       _redemptionRepository = redemptionRepository,
       super(initialState) {
    on<ParentRewards_Event_LoadRewards>(
      _onLoadRewards,
      transformer: sequential(),
    );
    on<ParentRewards_Event_LoadRedemptions>(
      _onLoadRedemptions,
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

  final String _userId;
  final Reward_Repository _rewardRepository;
  final RewardRedemption_Repository _redemptionRepository;

  Future<void> _onLoadRewards(
    ParentRewards_Event_LoadRewards event,
    Emitter<ParentRewards_State> emit,
  ) async {
    emit(state.copyWith(loadStatus: ParentRewards_LoadStatus.loading));
    try {
      final rewards =
          await _rewardRepository.getRewardsByFamilyId(familyId: _userId);
      emit(
        state.copyWith(
          loadStatus: ParentRewards_LoadStatus.loaded,
          rewards: rewards,
        ),
      );
    } catch (e, stackTrace) {
      log.warning('${event.runtimeType}: error', e, stackTrace);
      emit(
        state.copyWith(
          loadStatus: ParentRewards_LoadStatus.error,
          setLoadErrorMessage: e.toString,
        ),
      );
    }
  }

  Future<void> _onLoadRedemptions(
    ParentRewards_Event_LoadRedemptions event,
    Emitter<ParentRewards_State> emit,
  ) async {
    emit(
      state.copyWith(
        redemptionLoadStatus:
            ParentRewards_RedemptionLoadStatus.loading,
      ),
    );
    try {
      final redemptions =
          await _redemptionRepository.getRedemptionHistory(
        parentId: _userId,
      );
      emit(
        state.copyWith(
          redemptionLoadStatus:
              ParentRewards_RedemptionLoadStatus.loaded,
          redemptions: redemptions,
        ),
      );
    } catch (e, stackTrace) {
      log.warning('${event.runtimeType}: error', e, stackTrace);
      emit(
        state.copyWith(
          redemptionLoadStatus:
              ParentRewards_RedemptionLoadStatus.error,
          setRedemptionLoadErrorMessage: e.toString,
        ),
      );
    }
  }

  Future<void> _onAddReward(
    ParentRewards_Event_AddReward event,
    Emitter<ParentRewards_State> emit,
  ) async {
    emit(state.copyWith(createStatus: ParentRewards_CreateStatus.creating));
    try {
      // Ensure parentId is set to the current user's ID
      final rewardToCreate = event.reward.parentId.isEmpty
          ? Reward(
              id: event.reward.id,
              parentId: _userId,
              name: event.reward.name,
              description: event.reward.description,
              points: event.reward.points,
              createdAt: event.reward.createdAt,
              updatedAt: event.reward.updatedAt,
            )
          : event.reward;

      await _rewardRepository.createReward(reward: rewardToCreate);
      emit(state.copyWith(createStatus: ParentRewards_CreateStatus.success));
      add(const ParentRewards_Event_LoadRewards());
    } catch (e, stackTrace) {
      log.warning('${event.runtimeType}: error', e, stackTrace);
      emit(
        state.copyWith(
          createStatus: ParentRewards_CreateStatus.error,
          setCreateErrorMessage: e.toString,
        ),
      );
    }
  }

  Future<void> _onUpdateReward(
    ParentRewards_Event_UpdateReward event,
    Emitter<ParentRewards_State> emit,
  ) async {
    emit(state.copyWith(updateStatus: ParentRewards_UpdateStatus.updating));
    try {
      await _rewardRepository.updateReward(reward: event.reward);
      emit(state.copyWith(updateStatus: ParentRewards_UpdateStatus.success));
      add(const ParentRewards_Event_LoadRewards());
    } catch (e, stackTrace) {
      log.warning('${event.runtimeType}: error', e, stackTrace);
      emit(
        state.copyWith(
          updateStatus: ParentRewards_UpdateStatus.error,
          setUpdateErrorMessage: e.toString,
        ),
      );
    }
  }

  Future<void> _onDeleteReward(
    ParentRewards_Event_DeleteReward event,
    Emitter<ParentRewards_State> emit,
  ) async {
    emit(state.copyWith(deleteStatus: ParentRewards_DeleteStatus.deleting));
    try {
      await _rewardRepository.deleteReward(id: event.rewardId);
      emit(state.copyWith(deleteStatus: ParentRewards_DeleteStatus.success));
      add(const ParentRewards_Event_LoadRewards());
    } catch (e, stackTrace) {
      log.warning('${event.runtimeType}: error', e, stackTrace);
      emit(
        state.copyWith(
          deleteStatus: ParentRewards_DeleteStatus.error,
          setDeleteErrorMessage: e.toString,
        ),
      );
    }
  }
}
