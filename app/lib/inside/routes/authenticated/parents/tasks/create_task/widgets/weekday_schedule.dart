import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../../shared/models/enums/days_of_week.dart';
import '../../../../../../../shared/models/enums/part_of_day.dart';
import '../../../../../../i18n/translations.g.dart';

class CreateTask_Widget_WeekdaySchedule extends StatefulWidget {
  final Map<DaysOfWeek, Set<PartOfDay>> dayControllers;
  final ValueNotifier<String?> errorNotifier;
  final bool isCreating;

  const CreateTask_Widget_WeekdaySchedule({
    required this.dayControllers,
    required this.errorNotifier,
    required this.isCreating,
    super.key,
  });

  @override
  State<CreateTask_Widget_WeekdaySchedule> createState() =>
      _CreateTask_Widget_WeekdayScheduleState();
}

class _CreateTask_Widget_WeekdayScheduleState
    extends State<CreateTask_Widget_WeekdaySchedule> {
  bool _shouldExpandDay(DaysOfWeek day) {
    if (widget.isCreating) {
      // When creating a task, expand all days
      return true;
    } else {
      // When editing, only expand days that have selections
      return widget.dayControllers[day]?.isNotEmpty ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.tasks.weeklySchedule,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(4),
        Text(
          t.tasks.weeklyScheduleDescription,
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
        const Gap(16),
        ...DaysOfWeek.values.map((day) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ExpansionTile(
                initiallyExpanded: _shouldExpandDay(day),
                title: Text(
                  day.fullName,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                backgroundColor:
                    const Color(0xFF3B82F6).withValues(alpha: 0.05),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: PartOfDay.values.map((partOfDay) {
                        final isSelected =
                            widget.dayControllers[day]?.contains(partOfDay) ??
                                false;
                        return FilterChip(
                          label: Text(partOfDay.displayName),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                widget.dayControllers[day]?.add(partOfDay);
                              } else {
                                widget.dayControllers[day]?.remove(partOfDay);
                              }
                              // Clear error when user makes a selection
                              final hasAnySelection =
                                  widget.dayControllers.values.any(
                                (set) => set.isNotEmpty,
                              );
                              if (hasAnySelection) {
                                widget.errorNotifier.value = null;
                              }
                            });
                          },
                          backgroundColor: Colors.grey[100],
                          selectedColor: const Color(0xFF3B82F6),
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        ValueListenableBuilder<String?>(
          valueListenable: widget.errorNotifier,
          builder: (context, error, child) {
            if (error == null) return const SizedBox.shrink();
            return Column(
              children: [
                const Gap(8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    border: Border.all(
                      color: Colors.red.withValues(alpha: 0.3),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    error,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
