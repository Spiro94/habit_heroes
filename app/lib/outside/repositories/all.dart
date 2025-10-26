import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_user/repository.dart';
import 'auth/repository.dart';
import 'base.dart';
import 'completions/repository.dart';
import 'family/repository.dart';
import 'rewards/repository.dart';
import 'tasks/repository.dart';

/// When adding a new repository, be sure to add it to:
/// - [getList]
/// - [createProviders]
///   - Make sure to add the concrete type to `RepositoryProvider<ConcreteType>`
///     otherwise it will register the base class.
class Repositories_All {
  const Repositories_All({
    required this.appUserRepository,
    required this.authRepository,
    required this.rewardRepository,
    required this.taskCompletionRepository,
    required this.taskRepository,
    required this.familyRepository,
  });

  final AppUser_Repository appUserRepository;
  final Auth_Repository authRepository;
  final Reward_Repository rewardRepository;
  final TaskCompletion_Repository taskCompletionRepository;
  final Task_Repository taskRepository;
  final Family_Repository familyRepository;

  List<Repository_Base> getList() => [
    appUserRepository,
    authRepository,
    rewardRepository,
    taskCompletionRepository,
    taskRepository,
    familyRepository,
  ];

  List<RepositoryProvider<Repository_Base>> createProviders() {
    return [
      RepositoryProvider<AppUser_Repository>.value(value: appUserRepository),
      RepositoryProvider<Auth_Repository>.value(value: authRepository),
      RepositoryProvider<Reward_Repository>.value(value: rewardRepository),
      RepositoryProvider<TaskCompletion_Repository>.value(
        value: taskCompletionRepository,
      ),
      RepositoryProvider<Task_Repository>.value(value: taskRepository),
      RepositoryProvider<Family_Repository>.value(value: familyRepository),
    ];
  }

  Future<void> initialize() async {
    await Future.forEach(getList(), (r) async {
      r.log.fine('init');
      await r.init();
    });
  }
}
