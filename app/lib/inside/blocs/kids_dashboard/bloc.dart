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
    on<KidsDashboard_Event_UncompleteTask>(_onUncompleteTask);
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
      emit(state.copyWith(status: KidsDashboard_Status.loading));

      // Load today's tasks, kids points, and rewards in parallel
      final todayTasks = await _kidsDashboardRepository.getTodayTasks();
      final kidsPoints = await _kidsDashboardRepository.getKidsPoints();
      final rewards = await _kidsDashboardRepository.getRewards();

      emit(
        state.copyWith(
          status: KidsDashboard_Status.loaded,
          todayTasks: todayTasks,
          kidsPoints: kidsPoints,
          rewards: rewards,
          setErrorMessage: () => null,
        ),
      );
    } catch (e, stackTrace) {
      log.severe('Error loading kids dashboard data', e, stackTrace);
      emit(
        state.copyWith(
          status: KidsDashboard_Status.loadError,
          setErrorMessage: e.toString,
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
      emit(state.copyWith(status: KidsDashboard_Status.completing));

      await _kidsDashboardRepository.completeTask(instanceId: event.instanceId);

      final kidsPoints = await _kidsDashboardRepository.getKidsPoints();

      emit(
        state.copyWith(
          status: KidsDashboard_Status.completeSuccess,
          kidsPoints: kidsPoints,
          setErrorMessage: () => null,
        ),
      );

      // Reload data to get updated tasks and points
      add(const KidsDashboard_Event_RefreshData());
    } catch (e, stackTrace) {
      log.severe('Error completing task', e, stackTrace);
      emit(
        state.copyWith(
          status: KidsDashboard_Status.completeError,
          setErrorMessage: e.toString,
        ),
      );
    }
  }

  Future<void> _onUncompleteTask(
    KidsDashboard_Event_UncompleteTask event,
    Emitter<KidsDashboard_State> emit,
  ) async {
    log.info('_onUncompleteTask: ${event.instanceId}');

    try {
      emit(state.copyWith(status: KidsDashboard_Status.uncompleting));

      await _kidsDashboardRepository.uncompleteTask(
        instanceId: event.instanceId,
      );

      final kidsPoints = await _kidsDashboardRepository.getKidsPoints();

      emit(
        state.copyWith(
          status: KidsDashboard_Status.uncompleteSuccess,
          kidsPoints: kidsPoints,
          setErrorMessage: () => null,
        ),
      );

      // Reload data to get updated tasks and points
      add(const KidsDashboard_Event_RefreshData());
    } catch (e, stackTrace) {
      log.severe('Error uncompleting task', e, stackTrace);
      emit(
        state.copyWith(
          status: KidsDashboard_Status.uncompleteError,
          setErrorMessage: e.toString,
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
      emit(state.copyWith(status: KidsDashboard_Status.skipping));

      await _kidsDashboardRepository.skipTask(instanceId: event.instanceId);

      emit(
        state.copyWith(
          status: KidsDashboard_Status.skipSuccess,
          setErrorMessage: () => null,
        ),
      );

      // Reload data to get updated tasks
      add(const KidsDashboard_Event_RefreshData());
    } catch (e, stackTrace) {
      log.severe('Error skipping task', e, stackTrace);
      emit(
        state.copyWith(
          status: KidsDashboard_Status.skipError,
          setErrorMessage: e.toString,
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
      emit(state.copyWith(status: KidsDashboard_Status.redeeming));

      await _kidsDashboardRepository.redeemReward(
        rewardId: event.rewardId,
        kidId: event.kidId,
      );

      emit(
        state.copyWith(
          status: KidsDashboard_Status.redeemSuccess,
          setErrorMessage: () => null,
        ),
      );

      // Refresh data to update points
      add(const KidsDashboard_Event_RefreshData());
    } catch (e, stackTrace) {
      log.severe('Error redeeming reward', e, stackTrace);
      emit(
        state.copyWith(
          status: KidsDashboard_Status.redeemError,
          setErrorMessage: e.toString,
        ),
      );
    }
  }
}
