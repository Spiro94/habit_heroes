import 'package:flutter/material.dart';

import '../../../../../shared/models/enums/part_of_day.dart';
import '../../../../../shared/models/today_task.dart';
import 'task_card.dart';

class KidsDashboard_Widget_PartOfDaySection extends StatelessWidget {
  const KidsDashboard_Widget_PartOfDaySection({
    super.key,
    required this.partOfDay,
    required this.tasks,
    required this.isCurrentSection,
    required this.onTaskCompleted,
  });

  final PartOfDay partOfDay;
  final List<TodayTask> tasks;
  final bool isCurrentSection;
  final ValueChanged<TodayTask> onTaskCompleted;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16, top: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color:
                isCurrentSection
                    ? const Color(0xFFEC4899).withOpacity(0.2)
                    : Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  isCurrentSection
                      ? const Color(0xFFEC4899)
                      : Colors.grey[300]!,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Icon(
                _iconForPartOfDay(partOfDay),
                color:
                    isCurrentSection
                        ? const Color(0xFFEC4899)
                        : Colors.grey[600],
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                partOfDay.displayName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color:
                      isCurrentSection
                          ? const Color(0xFFEC4899)
                          : Colors.grey[800],
                ),
              ),
              if (isCurrentSection) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEC4899),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Ahora',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        ...tasks.map((task) {
          return KidsDashboard_Widget_TaskCard(
            task: task,
            onComplete: () => onTaskCompleted(task),
          );
        }),
      ],
    );
  }

  IconData _iconForPartOfDay(PartOfDay partOfDay) {
    switch (partOfDay) {
      case PartOfDay.morning:
        return Icons.wb_sunny;
      case PartOfDay.afternoon:
        return Icons.wb_cloudy;
      case PartOfDay.night:
        return Icons.nightlight_round;
    }
  }
}
