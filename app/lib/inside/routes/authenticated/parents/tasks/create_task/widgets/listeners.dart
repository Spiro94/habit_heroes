import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../shared/widgets/all.dart';
import '../../../../../../blocs/parent_tasks/bloc.dart';
import '../../../../../../blocs/parent_tasks/state.dart';
import '../../../../../../i18n/translations.g.dart';
import '../../../../../router.dart';

class CreateTask_Listeners extends StatelessWidget {
  final Widget child;
  final VoidCallback? onLoadEditingDataSuccess;

  const CreateTask_Listeners({
    required this.child,
    this.onLoadEditingDataSuccess,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ParentTasks_Bloc, ParentTasks_State>(
          listenWhen: (previous, current) =>
              previous.createTaskStatus != current.createTaskStatus,
          listener: (context, state) {
            if (state.createTaskStatus == CreateTaskStatus.error) {
              showDialog<void>(
                context: context,
                builder: (context) => HabitHeroes_Dialog(
                  title: t.tasks.errorCreatingTask,
                  dialogType: HabitHeroesDialogType.error,
                  icon: Icons.error_outline,
                  body: Text(
                    state.createTaskErrorMessage ?? t.tasks.errorCreatingTask,
                  ),
                  actions: [
                    HabitHeroesDialogAction(
                      label: t.kids.cancel,
                      isPrimary: true,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            } else if (state.createTaskStatus == CreateTaskStatus.success) {
              context.router.navigate(const TaskList_Route());
            }
          },
        ),
        BlocListener<ParentTasks_Bloc, ParentTasks_State>(
          listenWhen: (previous, current) =>
              previous.updateTaskStatus != current.updateTaskStatus,
          listener: (context, state) {
            if (state.updateTaskStatus == UpdateTaskStatus.error) {
              showDialog<void>(
                context: context,
                builder: (context) => HabitHeroes_Dialog(
                  title: t.tasks.errorUpdatingTask,
                  dialogType: HabitHeroesDialogType.error,
                  icon: Icons.error_outline,
                  body: Text(
                    state.updateTaskErrorMessage ?? t.tasks.errorUpdatingTask,
                  ),
                  actions: [
                    HabitHeroesDialogAction(
                      label: t.kids.cancel,
                      isPrimary: true,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            } else if (state.updateTaskStatus == UpdateTaskStatus.success) {
              context.router.navigate(const TaskList_Route());
            }
          },
        ),
        BlocListener<ParentTasks_Bloc, ParentTasks_State>(
          listenWhen: (previous, current) =>
              previous.loadEditingDataStatus != current.loadEditingDataStatus,
          listener: (context, state) {
            if (state.loadEditingDataStatus == LoadEditingDataStatus.loaded) {
              // Call the prefill callback if provided
              onLoadEditingDataSuccess?.call();
            } else if (state.loadEditingDataStatus ==
                LoadEditingDataStatus.error) {
              showDialog<void>(
                context: context,
                builder: (context) => HabitHeroes_Dialog(
                  title: t.tasks.errorLoadingTask,
                  dialogType: HabitHeroesDialogType.error,
                  icon: Icons.error_outline,
                  body: Text(
                    state.loadEditingDataErrorMessage ??
                        t.tasks.errorLoadingTask,
                  ),
                  actions: [
                    HabitHeroesDialogAction(
                      label: t.kids.cancel,
                      isPrimary: true,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ],
      child: child,
    );
  }
}
