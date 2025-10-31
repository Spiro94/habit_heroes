
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/models/enums/part_of_day.dart';
import '../../../../shared/models/today_task.dart';
import '../../../blocs/kids_dashboard/bloc.dart';
import '../../../i18n/translations.g.dart';
import 'widgets/date_header.dart';
import 'widgets/rewards_tab_widget.dart';
import 'widgets/task_card.dart';

class KidsDashboard_TabletPage extends StatefulWidget {
  const KidsDashboard_TabletPage({super.key});

  @override
  State<KidsDashboard_TabletPage> createState() =>
      _KidsDashboard_TabletPageState();
}

class _KidsDashboard_TabletPageState extends State<KidsDashboard_TabletPage> {
  int _selectedDestination = 0;

  @override
  Widget build(BuildContext context) {
    final t = context.t.kidsDashboard;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.appBar.greetingTablet,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFEC4899),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => context.router.popUntilRoot(),
        ),
      ),
      body: SafeArea(
        child: Row(
          children: [
            NavigationRail(
              selectedIndex: _selectedDestination,
              onDestinationSelected: (index) {
                setState(() => _selectedDestination = index);
              },
              labelType: NavigationRailLabelType.all,
              destinations: [
                NavigationRailDestination(
                  icon: const Icon(Icons.task_alt_outlined),
                  selectedIcon: const Icon(Icons.task_alt),
                  label: Text(t.navigation.tasks),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.stars_outlined),
                  selectedIcon: const Icon(Icons.stars),
                  label: Text(t.navigation.rewards),
                ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: IndexedStack(
                  index: _selectedDestination,
                  children: const [
                    _KidsDashboard_TabletTasksView(),
                    KidsDashboard_Widget_RewardsTab(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KidsDashboard_TabletTasksView extends StatelessWidget {
  const _KidsDashboard_TabletTasksView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KidsDashboard_Bloc, KidsDashboard_State>(
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

        final tasksByKid = _groupTasksByKid(tasks);
        final currentPartOfDay = _resolveCurrentPartOfDay();

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const KidsDashboard_Widget_DateHeader(),
              const SizedBox(height: 24),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: tasksByKid.entries
                      .map(
                        (entry) => Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: _KidTaskColumn(
                            kidName: entry.key,
                            tasks: entry.value,
                            currentPartOfDay: currentPartOfDay,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Map<String, List<TodayTask>> _groupTasksByKid(
    List<TodayTask> tasks,
  ) {
    final sortedMap = <String, List<TodayTask>>{};

    final entries = <String, List<TodayTask>>{};
    for (final task in tasks) {
      entries.putIfAbsent(task.kidName, () => []).add(task);
    }

    final sortedKeys = entries.keys.toList()..sort();
    for (final kidName in sortedKeys) {
      final kidTasks = List<TodayTask>.from(entries[kidName]!);
      kidTasks.sort(_compareTasksByPartOfDay);
      sortedMap[kidName] = kidTasks;
    }
    return sortedMap;
  }

  int _compareTasksByPartOfDay(TodayTask a, TodayTask b) {
    final aIndex = _partOfDayIndex(a.timeOfDay);
    final bIndex = _partOfDayIndex(b.timeOfDay);
    if (aIndex != bIndex) {
      return aIndex.compareTo(bIndex);
    }
    return a.taskTitle.toLowerCase().compareTo(b.taskTitle.toLowerCase());
  }

  int _partOfDayIndex(String key) {
    final index = PartOfDay.values.indexWhere((part) => part.key == key);
    return index == -1 ? 0 : index;
  }
}

class _KidTaskColumn extends StatelessWidget {
  const _KidTaskColumn({
    required this.kidName,
    required this.tasks,
    required this.currentPartOfDay,
  });

  final String kidName;
  final List<TodayTask> tasks;
  final PartOfDay currentPartOfDay;

  @override
  Widget build(BuildContext context) {
    final kidColor = _resolveKidColor(tasks.first.kidColor);
    final tasksByPartOfDay = <PartOfDay, List<TodayTask>>{
      for (final part in PartOfDay.values) part: [],
    };

    for (final task in tasks) {
      final part = PartOfDay.values.firstWhere(
        (value) => value.key == task.timeOfDay,
        orElse: () => PartOfDay.morning,
      );
      tasksByPartOfDay[part]!.add(task);
    }

    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _KidColumnHeader(kidName: kidName, color: kidColor),
          const SizedBox(height: 16),
          ...PartOfDay.values.expand((part) {
            final partTasks = tasksByPartOfDay[part]!;
            if (partTasks.isEmpty) {
              return const Iterable<Widget>.empty();
            }

            final isCurrent = part == currentPartOfDay;
            return [
              _PartOfDayLabel(part: part, isCurrent: isCurrent),
              const SizedBox(height: 12),
              ...partTasks.map(
                (task) => KidsDashboard_Widget_TaskCard(
                  task: task,
                  onComplete: () {
                    context.read<KidsDashboard_Bloc>().add(
                      KidsDashboard_Event_CompleteTask(
                        instanceId: task.instanceId,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
            ];
          }),
        ],
      ),
    );
  }

  Color _resolveKidColor(String? color) {
    if (color == null || color.isEmpty) {
      return const Color(0xFF6366F1);
    }
    try {
      return Color(int.parse(color.replaceFirst('#', '0xFF')));
    } catch (_) {
      return const Color(0xFF6366F1);
    }
  }
}

class _KidColumnHeader extends StatelessWidget {
  const _KidColumnHeader({required this.kidName, required this.color});

  final String kidName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: Text(
              kidName.isNotEmpty ? kidName[0].toUpperCase() : '?',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              kidName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _PartOfDayLabel extends StatelessWidget {
  const _PartOfDayLabel({required this.part, required this.isCurrent});

  final PartOfDay part;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final translations = context.t.kidsDashboard.tasks;
    final color = _colorForPartOfDay(part);
    final nowLabel = translations.now;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isCurrent ? 0.25 : 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: isCurrent ? 1 : 0.6),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_iconForPartOfDay(part), size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            part.displayName,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: color.darken(0.2),
            ),
          ),
          if (isCurrent) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                nowLabel,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _colorForPartOfDay(PartOfDay part) {
    switch (part) {
      case PartOfDay.morning:
        return const Color(0xFFFACC15);
      case PartOfDay.afternoon:
        return const Color(0xFFF97316);
      case PartOfDay.night:
        return const Color(0xFF1E3A8A);
    }
  }

  IconData _iconForPartOfDay(PartOfDay part) {
    switch (part) {
      case PartOfDay.morning:
        return Icons.wb_sunny;
      case PartOfDay.afternoon:
        return Icons.wb_cloudy;
      case PartOfDay.night:
        return Icons.nightlight_round;
    }
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

extension _ColorBrightness on Color {
  Color darken(double amount) {
    final hsl = HSLColor.fromColor(this);
    final brightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(brightness).toColor();
  }
}
