import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../outside/repositories/kids/repository.dart';
import '../../../../../outside/repositories/task_instances/repository.dart';
import '../../../../../outside/repositories/task_schedules/repository.dart';
import '../../../../../outside/repositories/task_templates/repository.dart';
import '../../../../blocs/auth/bloc.dart';
import '../../../../blocs/parent_tasks/bloc.dart';
import '../../../../blocs/parent_tasks/events.dart';
import '../../../../blocs/parent_tasks/state.dart';

@RoutePage(name: 'ParentTasks_Routes')
class ParentTasks_Router extends StatelessWidget {
  const ParentTasks_Router({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = context.read<Auth_Bloc>().state.appUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    return BlocProvider(
      create: (context) => ParentTasks_Bloc(
        userId: userId,
        taskInstanceRepository: context.read<TaskInstance_Repository>(),
        kidRepository: context.read<Kids_Repository>(),
        taskTemplateRepository: context.read<TaskTemplate_Repository>(),
        taskScheduleRepository: context.read<TaskSchedule_Repository>(),
        initialState: ParentTasks_State.initial(),
      )..add(const ParentTasks_Event_LoadTasks()),
      child: const AutoRouter(),
    );
  }
}
