import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:gap/gap.dart';

import '../../../../../../../shared/models/enums/days_of_week.dart';
import '../../../../../../../shared/models/enums/part_of_day.dart';
import '../../../../../../i18n/translations.g.dart';

class CreateTask_Widget_WeekdaySchedule extends StatefulWidget {
  final Map<DaysOfWeek, FSelectTileGroupController<PartOfDay>> dayControllers;
  final ValueNotifier<String?> errorNotifier;

  const CreateTask_Widget_WeekdaySchedule({
    required this.dayControllers,
    required this.errorNotifier,
    super.key,
  });

  @override
  State<CreateTask_Widget_WeekdaySchedule> createState() =>
      _CreateTask_Widget_WeekdayScheduleState();
}

class _CreateTask_Widget_WeekdayScheduleState
    extends State<CreateTask_Widget_WeekdaySchedule> {
  @override
  void initState() {
    super.initState();
    // Listen to all day controllers
    for (final controller in widget.dayControllers.values) {
      controller.addListener(_onSelectionChanged);
    }
  }

  @override
  void dispose() {
    // Remove listeners from all day controllers
    for (final controller in widget.dayControllers.values) {
      controller.removeListener(_onSelectionChanged);
    }
    super.dispose();
  }

  void _onSelectionChanged() {
    // Clear error when user makes any selection
    final hasAnySelection = widget.dayControllers.values.any(
      (controller) => controller.value.isNotEmpty,
    );
    if (hasAnySelection) {
      widget.errorNotifier.value = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.tasks.weeklySchedule,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const Gap(8),
        Text(
          t.tasks.weeklyScheduleDescription,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const Gap(16),
        ...DaysOfWeek.values.map((day) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: GestureDetector(
              onTap: () {
                // Dismiss keyboard when tapping on the tile group
                FocusScope.of(context).unfocus();
              },
              child: FSelectTileGroup<PartOfDay>(
                selectController: widget.dayControllers[day]!,
                label: Text(day.fullName),
                semanticsLabel: day.fullName,
                divider: FItemDivider.full,
                children: PartOfDay.values.map((partOfDay) {
                  return FSelectTile<PartOfDay>(
                    title: Text(partOfDay.displayName),
                    value: partOfDay,
                  );
                }).toList(),
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
                Text(
                  error,
                  style: TextStyle(
                    color: context.theme.colors.error,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
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
