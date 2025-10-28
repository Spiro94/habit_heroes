import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../outside/repositories/kids_dashboard/repository.dart';
import '../../../shared/mixins/logging.dart';
import 'events.dart';
import 'state.dart';

export 'events.dart';
export 'state.dart';

class KidsDashboard_Bloc extends Bloc<KidsDashboard_Event, KidsDashboard_State>
    with SharedMixin_Logging {
  KidsDashboard_Bloc({
    required KidsDashboard_Repository kidsDashboardRepository,
  }) : _kidsDashboardRepository = kidsDashboardRepository,
       super(KidsDashboard_State.initial()) {
    on<KidsDashboard_Event_LoadData>(_onLoadData);
    on<KidsDashboard_Event_CompleteTask>(_onCompleteTask);
    on<KidsDashboard_Event_SkipTask>(_onSkipTask);
    on<KidsDashboard_Event_RefreshData>(_onRefreshData);
    on<KidsDashboard_Event_RedeemReward>(_onRedeemReward);
  }

  final KidsDashboard_Repository _kidsDashboardRepository;

  Future<void> _onLoadData(
    KidsDashboard_Event_LoadData event,
    Emitter<KidsDashboard_State> emit,
  ) async {
    log.info('_onLoadData');

    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));

      // Load today's tasks, kids points, and rewards in parallel
      final todayTasks = await _kidsDashboardRepository.getTodayTasks();
      final kidsPoints = await _kidsDashboardRepository.getKidsPoints();
      final rewards = await _kidsDashboardRepository.getRewards();

      emit(
        state.copyWith(
          loadStatus: LoadStatus.loaded,
          todayTasks: todayTasks,
          kidsPoints: kidsPoints,
          rewards: rewards,
          setLoadErrorMessage: () => null,
        ),
      );
    } catch (e, stackTrace) {
      log.severe('Error loading kids dashboard data', e, stackTrace);
      emit(
        state.copyWith(
          loadStatus: LoadStatus.error,
          setLoadErrorMessage: e.toString,
        ),
      );
    }
  }

  Future<void> _onCompleteTask(
    KidsDashboard_Event_CompleteTask event,
    Emitter<KidsDashboard_State> emit,
  ) async {
    log.info('_onCompleteTask: ${event.instanceId}');

    try {
      emit(state.copyWith(completeTaskStatus: CompleteTaskStatus.completing));

      await _kidsDashboardRepository.completeTask(instanceId: event.instanceId);

      final kidsPoints = await _kidsDashboardRepository.getKidsPoints();

      emit(
        state.copyWith(
          completeTaskStatus: CompleteTaskStatus.success,
          kidsPoints: kidsPoints,
          setCompleteTaskErrorMessage: () => null,
        ),
      );

      // Reload data to get updated tasks and points
      add(const KidsDashboard_Event_RefreshData());
    } catch (e, stackTrace) {
      log.severe('Error completing task', e, stackTrace);
      emit(
        state.copyWith(
          completeTaskStatus: CompleteTaskStatus.error,
          setCompleteTaskErrorMessage: e.toString,
        ),
      );
    }
  }

  Future<void> _onSkipTask(
    KidsDashboard_Event_SkipTask event,
    Emitter<KidsDashboard_State> emit,
  ) async {
    log.info('_onSkipTask: ${event.instanceId}');

    try {
      emit(state.copyWith(skipTaskStatus: SkipTaskStatus.skipping));

      await _kidsDashboardRepository.skipTask(instanceId: event.instanceId);

      emit(
        state.copyWith(
          skipTaskStatus: SkipTaskStatus.success,
          setSkipTaskErrorMessage: () => null,
        ),
      );

      // Reload data to get updated tasks
      add(const KidsDashboard_Event_RefreshData());
    } catch (e, stackTrace) {
      log.severe('Error skipping task', e, stackTrace);
      emit(
        state.copyWith(
          skipTaskStatus: SkipTaskStatus.error,
          setSkipTaskErrorMessage: e.toString,
        ),
      );
    }
  }

  Future<void> _onRefreshData(
    KidsDashboard_Event_RefreshData event,
    Emitter<KidsDashboard_State> emit,
  ) async {
    log.info('_onRefreshData');

    try {
      // Load data without changing loading status (silent refresh)
      final todayTasks = await _kidsDashboardRepository.getTodayTasks();
      final kidsPoints = await _kidsDashboardRepository.getKidsPoints();

      emit(state.copyWith(todayTasks: todayTasks, kidsPoints: kidsPoints));
    } catch (e, stackTrace) {
      log.severe('Error refreshing kids dashboard data', e, stackTrace);
      // Don't update error state on silent refresh failures
    }
  }

  Future<void> _onRedeemReward(
    KidsDashboard_Event_RedeemReward event,
    Emitter<KidsDashboard_State> emit,
  ) async {
    log.info('_onRedeemReward: ${event.rewardId} for kid ${event.kidId}');

    try {
      emit(state.copyWith(redeemRewardStatus: RedeemRewardStatus.redeeming));

      await _kidsDashboardRepository.redeemReward(
        rewardId: event.rewardId,
        kidId: event.kidId,
      );

      emit(
        state.copyWith(
          redeemRewardStatus: RedeemRewardStatus.success,
          setRedeemRewardErrorMessage: () => null,
        ),
      );

      // Refresh data to update points
      add(const KidsDashboard_Event_RefreshData());
    } catch (e, stackTrace) {
      log.severe('Error redeeming reward', e, stackTrace);
      emit(
        state.copyWith(
          redeemRewardStatus: RedeemRewardStatus.error,
          setRedeemRewardErrorMessage: e.toString,
        ),
      );
    }
  }
}
