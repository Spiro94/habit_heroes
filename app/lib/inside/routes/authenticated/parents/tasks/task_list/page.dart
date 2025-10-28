import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../outside/theme/theme.dart';
import '../../../../../../shared/widgets/all.dart';
import '../../../../../blocs/parent_tasks/bloc.dart';
import '../../../../../blocs/parent_tasks/events.dart';
import '../../../../../blocs/parent_tasks/state.dart';
import '../../../../../i18n/translations.g.dart';
import '../../../../router.dart';
import '../../../../widgets/colorful_card.dart';

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
            padding: const EdgeInsets.all(8),
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
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: context.colors.tasksBlue.toLinearGradient(),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(24),
                    Text(
                      state.loadErrorMessage ?? 'Error loading tasks',
                      style: TextStyle(
                        fontSize: 16,
                        color: context.solidColors.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(24),
                    SizedBox(
                      height: 48,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.refresh),
                        label: Text(t.tasks.tryAgainButton),
                        onPressed: () {
                          context.read<ParentTasks_Bloc>().add(
                            const ParentTasks_Event_LoadTasks(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.colors.tasksBlue.start,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // Show templates (all created tasks)
          if (state.taskTemplates.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: context.colors.tasksBlue.toLinearGradient(),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.assignment_outlined,
                        size: 64,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(24),
                    Text(
                      t.tasks.noTasksAvailable,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: context.solidColors.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(24),
                    SizedBox(
                      height: 48,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: Text(t.tasks.createFirstTask),
                        onPressed: () =>
                            context.router.push(CreateTask_Route()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.colors.tasksBlue.start,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                padding: const EdgeInsets.only(bottom: 16),
                child: ColorfulCard(
                  gradient: context.colors.tasksBlue,
                  borderRadius: 16,
                  shadowBlur: 12,
                  shadowOffset: const Offset(0, 4),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        // Icon badge
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.assignment_outlined,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                template.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Gap(8),
                              // Assigned kids
                              if (kidNames.isNotEmpty) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.25),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.person,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                      const Gap(6),
                                      Flexible(
                                        child: Text(
                                          kidNames.join(', '),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(8),
                              ],
                              // Points badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.25),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                    const Gap(6),
                                    Text(
                                      '${template.points} puntos',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(8),
                              // Schedule info
                              Text(
                                scheduleText(),
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontStyle: FontStyle.italic,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const Gap(12),
                        // Action buttons
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Material(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: const CircleBorder(),
                              child: InkWell(
                                onTap: () {
                                  final firstScheduleId = schedules.isNotEmpty
                                      ? schedules.first.id
                                      : null;
                                  context.router.push(
                                    CreateTask_Route(
                                      taskScheduleId: firstScheduleId,
                                    ),
                                  );
                                },
                                customBorder: const CircleBorder(),
                                child: const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            const Gap(8),
                            Material(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: const CircleBorder(),
                              child: InkWell(
                                onTap: () =>
                                    _showDeleteDialog(context, template.id),
                                customBorder: const CircleBorder(),
                                child: const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
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
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) => HabitHeroes_Dialog(
      title: t.tasks.deleteTask,
      dialogType: HabitHeroesDialogType.error,
      icon: Icons.delete_outline,
      body: Text(t.tasks.deleteTaskConfirm),
      actions: [
        HabitHeroesDialogAction(
          label: t.kids.cancel,
          onPressed: () => Navigator.of(context).pop(),
        ),
        HabitHeroesDialogAction(
          label: t.tasks.delete,
          isPrimary: true,
          onPressed: () {
            bloc.add(ParentTasks_Event_DeleteTask(id: taskScheduleId));
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
