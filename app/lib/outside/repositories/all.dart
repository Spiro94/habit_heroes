import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_user/repository.dart';
import 'auth/repository.dart';
import 'base.dart';
import 'completions/repository.dart';
import 'kids/repository.dart';
import 'kids_dashboard/repository.dart';
import 'rewards/repository.dart';
import 'task_instances/repository.dart';
import 'task_schedules/repository.dart';
import 'task_templates/repository.dart';

/// When adding a new repository, be sure to add it to:
/// - [getList]
/// - [createProviders]
///   - Make sure to add the concrete type to `RepositoryProvider<ConcreteType>`
///     otherwise it will register the base class.
class Repositories_All {
  const Repositories_All({
    required this.appUserRepository,
    required this.authRepository,
    required this.kidRepository,
    required this.kidsDashboardRepository,
    required this.rewardRepository,
    required this.taskCompletionRepository,
    required this.taskTemplateRepository,
    required this.taskScheduleRepository,
    required this.taskInstanceRepository,
  });

  final AppUser_Repository appUserRepository;
  final Auth_Repository authRepository;
  final Kids_Repository kidRepository;
  final KidsDashboard_Repository kidsDashboardRepository;
  final Reward_Repository rewardRepository;
  final TaskCompletion_Repository taskCompletionRepository;
  final TaskTemplate_Repository taskTemplateRepository;
  final TaskSchedule_Repository taskScheduleRepository;
  final TaskInstance_Repository taskInstanceRepository;

  List<Repository_Base> getList() => [
    appUserRepository,
    authRepository,
    kidRepository,
    kidsDashboardRepository,
    rewardRepository,
    taskCompletionRepository,
    taskTemplateRepository,
    taskScheduleRepository,
    taskInstanceRepository,
  ];

  List<RepositoryProvider<Repository_Base>> createProviders() {
    return [
      RepositoryProvider<AppUser_Repository>.value(value: appUserRepository),
      RepositoryProvider<Auth_Repository>.value(value: authRepository),
      RepositoryProvider<Kids_Repository>.value(value: kidRepository),
      RepositoryProvider<KidsDashboard_Repository>.value(
        value: kidsDashboardRepository,
      ),
      RepositoryProvider<Reward_Repository>.value(value: rewardRepository),
      RepositoryProvider<TaskCompletion_Repository>.value(
        value: taskCompletionRepository,
      ),
      RepositoryProvider<TaskTemplate_Repository>.value(
        value: taskTemplateRepository,
      ),
      RepositoryProvider<TaskSchedule_Repository>.value(
        value: taskScheduleRepository,
      ),
      RepositoryProvider<TaskInstance_Repository>.value(
        value: taskInstanceRepository,
      ),
    ];
  }

  Future<void> initialize() async {
    await Future.forEach(getList(), (r) async {
      r.log.fine('init');
      await r.init();
    });
  }
}
