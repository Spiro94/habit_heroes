import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:gap/gap.dart';

import '../../../../../../i18n/translations.g.dart';

class CreateTask_Widget_SpecificDatePicker extends StatefulWidget {
  final FDateFieldController controller;
  final ValueNotifier<String?> errorNotifier;

  const CreateTask_Widget_SpecificDatePicker({
    required this.controller,
    required this.errorNotifier,
    super.key,
  });

  @override
  State<CreateTask_Widget_SpecificDatePicker> createState() =>
      _CreateTask_Widget_SpecificDatePickerState();
}

class _CreateTask_Widget_SpecificDatePickerState
    extends State<CreateTask_Widget_SpecificDatePicker> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onDateChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onDateChanged);
    super.dispose();
  }

  void _onDateChanged() {
    // Clear error when user selects a date
    if (widget.controller.value != null) {
      widget.errorNotifier.value = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FDateField.calendar(
          controller: widget.controller,
          label: Text(t.tasks.specificDate),
          description: Text(t.tasks.selectDateDescription),
          hint: t.tasks.specificDateHint,
        ),
        ValueListenableBuilder<String?>(
          valueListenable: widget.errorNotifier,
          builder: (context, error, child) {
            if (error == null) return const SizedBox.shrink();
            return Column(
              children: [
                const Gap(4),
                Text(
                  error,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
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
