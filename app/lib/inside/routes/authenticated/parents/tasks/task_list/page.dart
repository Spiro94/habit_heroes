import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:gap/gap.dart';

import '../../../../../blocs/parent_tasks/bloc.dart';
import '../../../../../blocs/parent_tasks/events.dart';
import '../../../../../blocs/parent_tasks/state.dart';
import '../../../../../util/breakpoints.dart';
import '../../../../router.dart';
import '../../../../widgets/scaffold.dart';

@RoutePage()
class TaskList_Page extends StatelessWidget {
  const TaskList_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaskList_Scaffold();
  }
}

class TaskList_Scaffold extends StatefulWidget {
  const TaskList_Scaffold({super.key});

  @override
  State<TaskList_Scaffold> createState() => _TaskList_ScaffoldState();
}

class _TaskList_ScaffoldState extends State<TaskList_Scaffold> {
  @override
  Widget build(BuildContext context) {
    return Routes_Scaffold(
      breakpointType: InsideUtil_BreakpointType.constrained,
      scaffold: FScaffold(
        header: FHeader.nested(
          prefixes: [
            FButton.icon(
              child: const Icon(Icons.arrow_back),
              onPress: () {
                context.router.maybePop();
              },
            ),
          ],
          title: const Text('Listado de tareas'),
          titleAlignment: Alignment.centerLeft,
          suffixes: [
            FButton(
              child: const Text('Crear tarea'),
              onPress: () {
                context.router.push(const CreateTask_Route());
              },
            ),
          ],
        ),
        footer: FloatingActionButton(
          onPressed: () => context.router.push(const CreateTask_Route()),
          child: const Icon(Icons.add),
        ),
        child: BlocBuilder<ParentTasks_Bloc, ParentTasks_State>(
          builder: (context, state) {
            if (state.status == ParentTasks_Status.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == ParentTasks_Status.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.errorMessage}'),
                    const Gap(16),
                    FButton(
                      onPress: () {
                        context.read<ParentTasks_Bloc>().add(
                          const ParentTasks_Event_LoadTasks(),
                        );
                      },
                      child: const Text('Intentar de nuevo'),
                    ),
                  ],
                ),
              );
            }
            if (state.tasks.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No hay tareas disponibles.'),
                    const Gap(16),
                    FButton(
                      child: const Text('Crea una tarea'),
                      onPress: () {
                        context.router.push(const CreateTask_Route());
                      },
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('Listado de tareas'));
          },
        ),
      ),
    );
  }
}
