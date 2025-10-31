import 'package:flutter/material.dart';

import '../../../../../shared/models/enums/part_of_day.dart';
import '../../../../../shared/models/today_task.dart';
import '../../../../i18n/translations.g.dart';
import 'task_card.dart';

class KidsDashboard_Widget_PartOfDaySection extends StatelessWidget {
  const KidsDashboard_Widget_PartOfDaySection({
    required this.partOfDay,
    required this.tasks,
    required this.isCurrentSection,
    required this.onTaskCompleted,
    super.key,
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

    final baseColor = _colorForPartOfDay(partOfDay);
    final backgroundColor = isCurrentSection
        ? baseColor.withValues(alpha: 0.25)
        : baseColor.withValues(alpha: 0.12);
    final borderColor = isCurrentSection
        ? baseColor
        : baseColor.withValues(alpha: 0.6);
    final nowLabel = context.t.kidsDashboard.tasks.now;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16, top: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Row(
            children: [
              Icon(_iconForPartOfDay(partOfDay), color: baseColor, size: 24),
              const SizedBox(width: 12),
              Text(
                partOfDay.displayName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: baseColor,
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
                    color: baseColor,
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

  Color _colorForPartOfDay(PartOfDay partOfDay) {
    switch (partOfDay) {
      case PartOfDay.morning:
        return const Color(0xFFFACC15); // warm yellow
      case PartOfDay.afternoon:
        return const Color(0xFFF97316); // vibrant orange
      case PartOfDay.night:
        return const Color(0xFF1E3A8A); // deep blue
    }
  }
}
