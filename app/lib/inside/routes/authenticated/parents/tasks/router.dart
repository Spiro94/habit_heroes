import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../outside/repositories/app_user/repository.dart';
import '../../../../../outside/repositories/tasks/repository.dart';
import '../../../../blocs/parent_tasks/bloc.dart';
import '../../../../blocs/parent_tasks/events.dart';
import '../../../../blocs/parent_tasks/state.dart';

@RoutePage(name: 'ParentTasks_Routes')
class ParentTasks_Router extends StatelessWidget {
  const ParentTasks_Router({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParentTasks_Bloc(
        taskRepository: context.read<Task_Repository>(),
        appUserRepository: context.read<AppUser_Repository>(),
        initialState: ParentTasks_State.initial(),
      )..add(const ParentTasks_Event_LoadTasks()),
      child: const AutoRouter(),
    );
  }
}
