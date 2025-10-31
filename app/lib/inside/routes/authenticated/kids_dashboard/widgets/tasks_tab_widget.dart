import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/models/enums/part_of_day.dart';
import '../../../../../shared/models/today_task.dart';
import '../../../../blocs/kids_dashboard/bloc.dart';
import '../../../../i18n/translations.g.dart';
import 'date_header.dart';
import 'part_of_day_section.dart';

class KidsDashboard_Widget_TasksTab extends StatelessWidget {
  const KidsDashboard_Widget_TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<KidsDashboard_Bloc, KidsDashboard_State>(
        builder: (context, state) {
          final translations = context.t;
          final kids = translations.kidsDashboard;
          final common = translations.common;

          if (state.loadStatus == LoadStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.loadStatus == LoadStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    state.loadErrorMessage != null
                        ? common.errorWithMessage(
                            message: state.loadErrorMessage!,
                          )
                        : common.unknownError,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<KidsDashboard_Bloc>().add(
                        const KidsDashboard_Event_LoadData(),
                      );
                    },
                    child: Text(common.retry),
                  ),
                ],
              ),
            );
          }

          final tasks = state.todayTasks;
          final currentPartOfDay = _resolveCurrentPartOfDay();

          if (tasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 64,
                    color: Colors.green[300],
                  ),
                  const SizedBox(height: 16),
                Text(
                  kids.tasks.emptyTitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  kids.tasks.emptySubtitle,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                ],
              ),
            );
          }

          final tasksByPartOfDay = <String, List<TodayTask>>{};
          for (final task in tasks) {
            tasksByPartOfDay.putIfAbsent(task.timeOfDay, () => []).add(task);
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const KidsDashboard_Widget_DateHeader(),
                const SizedBox(height: 16),
                ...PartOfDay.values.map((partOfDay) {
                  final partOfDayTasks = tasksByPartOfDay[partOfDay.key] ?? [];
                  return KidsDashboard_Widget_PartOfDaySection(
                    partOfDay: partOfDay,
                    tasks: partOfDayTasks,
                    isCurrentSection: partOfDay == currentPartOfDay,
                    onTaskCompleted: (task) {
                      context.read<KidsDashboard_Bloc>().add(
                        KidsDashboard_Event_CompleteTask(
                          instanceId: task.instanceId,
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}

PartOfDay _resolveCurrentPartOfDay() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return PartOfDay.morning;
  } else if (hour < 18) {
    return PartOfDay.afternoon;
  } else {
    return PartOfDay.night;
  }
}
