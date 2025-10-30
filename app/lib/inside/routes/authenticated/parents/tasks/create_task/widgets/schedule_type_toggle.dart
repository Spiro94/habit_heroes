import 'package:flutter/material.dart';

import '../../../../../../../outside/theme/theme.dart';
import '../../../../../../i18n/translations.g.dart';

class CreateTask_Widget_ScheduleTypeToggle extends StatelessWidget {
  final bool isSpecificDate;
  final ValueChanged<bool> onChanged;

  const CreateTask_Widget_ScheduleTypeToggle({
    required this.isSpecificDate,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.solidColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.solidColors.border),
      ),
      child: CheckboxListTile(
        value: isSpecificDate,
        onChanged: (value) => onChanged(value ?? false),
        title: Text(
          t.tasks.specificDateTask,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          t.tasks.specificDateDescription,
          style: TextStyle(
            fontSize: 13,
            color: context.solidColors.onSurfaceVariant,
          ),
        ),
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: context.colors.tasksBlue.start,
      ),
    );
  }
}
