import 'package:flutter/material.dart';

import '../models/enums/part_of_day.dart';

/// A reusable time picker field widget that shows a Material time picker dialog.
/// Supports time range validation based on part of day.
class TimePickerField extends StatelessWidget {
  const TimePickerField({
    required this.label,
    required this.value,
    required this.onChanged,
    this.partOfDay,
    super.key,
  });

  final String label;
  final TimeOfDay? value;
  final ValueChanged<TimeOfDay?> onChanged;
  final PartOfDay? partOfDay;

  /// Get default time based on part of day
  static TimeOfDay getDefaultTime(PartOfDay partOfDay) {
    switch (partOfDay) {
      case PartOfDay.morning:
        return const TimeOfDay(hour: 8, minute: 0); // 8:00 AM
      case PartOfDay.afternoon:
        return const TimeOfDay(hour: 14, minute: 0); // 2:00 PM
      case PartOfDay.night:
        return const TimeOfDay(hour: 19, minute: 0); // 7:00 PM
    }
  }

  /// Get time range constraints based on part of day
  static (TimeOfDay start, TimeOfDay end) getTimeRange(PartOfDay partOfDay) {
    switch (partOfDay) {
      case PartOfDay.morning:
        return (
          const TimeOfDay(hour: 6, minute: 0), // 6:00 AM
          const TimeOfDay(hour: 11, minute: 59), // 11:59 AM
        );
      case PartOfDay.afternoon:
        return (
          const TimeOfDay(hour: 12, minute: 0), // 12:00 PM
          const TimeOfDay(hour: 17, minute: 59), // 5:59 PM
        );
      case PartOfDay.night:
        return (
          const TimeOfDay(hour: 18, minute: 0), // 6:00 PM
          const TimeOfDay(hour: 23, minute: 59), // 11:59 PM
        );
    }
  }

  /// Check if a time is within the valid range for a part of day
  static bool isTimeInRange(TimeOfDay time, PartOfDay partOfDay) {
    final (start, end) = getTimeRange(partOfDay);
    final timeInMinutes = time.hour * 60 + time.minute;
    final startInMinutes = start.hour * 60 + start.minute;
    final endInMinutes = end.hour * 60 + end.minute;
    return timeInMinutes >= startInMinutes && timeInMinutes <= endInMinutes;
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final initialTime =
        value ??
        (partOfDay != null ? getDefaultTime(partOfDay!) : TimeOfDay.now());

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return child!;
      },
    );

    if (selectedTime != null) {
      // Validate time range if partOfDay is specified
      if (partOfDay != null && !isTimeInRange(selectedTime, partOfDay!)) {
        if (context.mounted) {
          final (start, end) = getTimeRange(partOfDay!);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Please select a time between ${start.format(context)} and ${end.format(context)}',
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
        return;
      }

      onChanged(selectedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showTimePicker(context),
      borderRadius: BorderRadius.circular(8),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.access_time),
        ),
        child: Text(
          value != null ? value!.format(context) : 'Select time',
          style: TextStyle(
            color: value != null
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}
