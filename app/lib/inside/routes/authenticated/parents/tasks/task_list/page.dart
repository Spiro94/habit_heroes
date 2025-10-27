import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:gap/gap.dart';

import '../../../../../blocs/parent_tasks/bloc.dart';
import '../../../../../blocs/parent_tasks/events.dart';
import '../../../../../blocs/parent_tasks/state.dart';
import '../../../../../i18n/translations.g.dart';
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
          title: Text(t.tasks.title),
          titleAlignment: Alignment.centerLeft,
          suffixes: [
            FButton(
              child: Text(t.tasks.createTask),
              onPress: () {
                context.router.push(CreateTask_Route());
              },
            ),
          ],
        ),
        child: BlocBuilder<ParentTasks_Bloc, ParentTasks_State>(
          builder: (context, state) {
            if (state.loadStatus == LoadStatus.loading ||
                state.loadStatus == LoadStatus.initial) {
              return const Center(child: FCircularProgress());
            }

            if (state.loadStatus == LoadStatus.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.loadErrorMessage}'),
                    const Gap(16),
                    FButton(
                      onPress: () {
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
                    FButton(
                      child: Text(t.tasks.createFirstTask),
                      onPress: () {
                        context.router.push(CreateTask_Route());
                      },
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
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
                  final specific = schedules.where(
                    (s) => s.specificDate != null,
                  );
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
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FCard(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                template.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Gap(4),
                              Text(
                                '${t.tasks.assignedToLabel} ${kidNames.join(', ')}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                              const Gap(4),
                              Text(
                                '${t.tasks.pointsLabel} ${template.points}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                              const Gap(4),
                              Text(
                                scheduleText(),
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // helper for mapping day indexes and time of day to readable names
                        FButton.icon(
                          style: FButtonStyle.primary(),
                          child: const Icon(Icons.edit),
                          onPress: () {
                            // navigate to edit: pass first schedule id if present
                            final firstScheduleId = schedules.isNotEmpty
                                ? schedules.first.id
                                : null;
                            context.router.push(
                              CreateTask_Route(taskScheduleId: firstScheduleId),
                            );
                          },
                        ),
                        const Gap(8),
                        FButton.icon(
                          style: FButtonStyle.destructive(),
                          child: const Icon(Icons.delete),
                          onPress: () =>
                              _showDeleteDialog(context, template.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
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
    builder: (context) => FDialog(
      direction: Axis.horizontal,
      title: Text(t.tasks.deleteTask),
      body: Text(t.tasks.deleteTaskConfirm),
      actions: [
        FButton(
          style: FButtonStyle.outline(),
          child: Text(t.kids.cancel),
          onPress: () => Navigator.of(context).pop(),
        ),
        FButton(
          style: FButtonStyle.destructive(),
          child: Text(t.tasks.delete),
          onPress: () {
            bloc.add(ParentTasks_Event_DeleteTask(id: taskScheduleId));
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
