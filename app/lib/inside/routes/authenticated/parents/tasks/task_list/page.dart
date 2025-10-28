import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../outside/theme/theme.dart';
import '../../../../../blocs/parent_tasks/bloc.dart';
import '../../../../../blocs/parent_tasks/events.dart';
import '../../../../../blocs/parent_tasks/state.dart';
import '../../../../../i18n/translations.g.dart';
import '../../../../router.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.tasks.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: context.colors.tasksBlue.start,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.router.maybePop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: Text(t.tasks.createTask),
              onPressed: () => context.router.push(CreateTask_Route()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: context.colors.tasksBlue.start,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ParentTasks_Bloc, ParentTasks_State>(
        builder: (context, state) {
          if (state.loadStatus == LoadStatus.loading ||
              state.loadStatus == LoadStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.loadStatus == LoadStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.loadErrorMessage}'),
                  const Gap(16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ParentTasks_Bloc>().add(
                        const ParentTasks_Event_LoadTasks(),
                      );
                    },
                    child: Text(t.tasks.tryAgainButton),
                  ),
                ],
              ),
            );
          }

          // Show templates (all created tasks)
          if (state.taskTemplates.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(t.tasks.noTasksAvailable),
                  const Gap(16),
                  ElevatedButton(
                    onPressed: () => context.router.push(CreateTask_Route()),
                    child: Text(t.tasks.createFirstTask),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            itemCount: state.taskTemplates.length,
            itemBuilder: (context, index) {
              final template = state.taskTemplates[index];

              // find schedules and kid names for this template
              final schedules = state.taskSchedules
                  .where((s) => s.taskTemplateId == template.id)
                  .toList();

              final kidNames = schedules
                  .map((s) {
                    final idx = state.kids.indexWhere((k) => k.id == s.kidId);
                    return idx >= 0 ? state.kids[idx].name : s.kidId;
                  })
                  .toSet()
                  .toList();

              String scheduleText() {
                if (schedules.isEmpty) return t.tasks.noSchedule;

                final parts = <String>[];

                // Handle specific dates first
                final specific = schedules.where((s) => s.specificDate != null);
                for (final s in specific) {
                  final dateStr = s.specificDate!
                      .toLocal()
                      .toIso8601String()
                      .split('T')
                      .first;
                  parts.add('${t.tasks.dateLabel} $dateStr');
                }

                // Group weekly schedules by day of week
                final weekly = schedules.where(
                  (s) => s.daysOfWeek != null && s.daysOfWeek!.isNotEmpty,
                );

                // Map: dayOfWeek -> List of parts of day
                final dayToParts = <int, List<String>>{};

                for (final schedule in weekly) {
                  for (final dayInt in schedule.daysOfWeek!) {
                    if (!dayToParts.containsKey(dayInt)) {
                      dayToParts[dayInt] = [];
                    }
                    if (schedule.timeOfDay != null) {
                      final partName = schedule.timeOfDay!.displayName;
                      if (!dayToParts[dayInt]!.contains(partName)) {
                        dayToParts[dayInt]!.add(partName);
                      }
                    }
                  }
                }

                // Sort days by day number (0=Sunday, 1=Monday, etc.)
                final sortedDays = dayToParts.keys.toList()..sort();

                // Format: "Monday: Morning, Afternoon"
                for (final dayInt in sortedDays) {
                  final dayName = _dayName(dayInt);
                  final partsList = dayToParts[dayInt]!;
                  if (partsList.isNotEmpty) {
                    parts.add('$dayName: ${partsList.join(', ')}');
                  } else {
                    parts.add(dayName);
                  }
                }

                return parts.join(' • ');
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        context.colors.tasksBlue.start.withValues(alpha: 0.05),
                        context.colors.datePickerCyan.start.withValues(
                          alpha: 0.05,
                        ),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: context.colors.tasksBlue.start.withValues(
                        alpha: 0.2,
                      ),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 80,
                          decoration: BoxDecoration(
                            color: context.colors.tasksBlue.start,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                template.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: context.solidColors.onSurface,
                                ),
                              ),
                              const Gap(6),
                              Text(
                                '${t.tasks.assignedToLabel} '
                                '${kidNames.join(', ')}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: context.solidColors.onSurfaceVariant,
                                ),
                              ),
                              const Gap(4),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: context.colors.pointsGold.start
                                          .withValues(alpha: 0.4),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      '⭐ ${template.points} pts',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: context.colors.pointsGold.end,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(6),
                              Text(
                                scheduleText(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: context.solidColors.onSurfaceVariant,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              color: context.colors.tasksBlue.start,
                              onPressed: () {
                                // navigate to edit: pass first schedule id if
                                // present
                                final firstScheduleId = schedules.isNotEmpty
                                    ? schedules.first.id
                                    : null;
                                context.router.push(
                                  CreateTask_Route(
                                    taskScheduleId: firstScheduleId,
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              color: context.solidColors.error,
                              onPressed: () =>
                                  _showDeleteDialog(context, template.id),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _dayName(int d) {
    switch (d) {
      case 0:
        return t.daysOfWeek.sunday.full;
      case 1:
        return t.daysOfWeek.monday.full;
      case 2:
        return t.daysOfWeek.tuesday.full;
      case 3:
        return t.daysOfWeek.wednesday.full;
      case 4:
        return t.daysOfWeek.thursday.full;
      case 5:
        return t.daysOfWeek.friday.full;
      case 6:
        return t.daysOfWeek.saturday.full;
      default:
        return d.toString();
    }
  }
}

void _showDeleteDialog(BuildContext context, String taskScheduleId) {
  final bloc = context.read<ParentTasks_Bloc>();
  showAdaptiveDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      title: Text(t.tasks.deleteTask),
      content: Text(t.tasks.deleteTaskConfirm),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.kids.cancel),
        ),
        TextButton(
          onPressed: () {
            bloc.add(ParentTasks_Event_DeleteTask(id: taskScheduleId));
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            foregroundColor: context.solidColors.error,
          ),
          child: Text(t.tasks.delete),
        ),
      ],
    ),
  );
}
