import 'package:flutter/material.dart';

import '../../../../../../i18n/translations.g.dart';

class CreateTask_Widget_SpecificDatePicker extends StatefulWidget {
  final DateTime? selectedDate;
  final void Function(DateTime) onDateChanged;
  final ValueNotifier<String?> errorNotifier;

  const CreateTask_Widget_SpecificDatePicker({
    required this.selectedDate,
    required this.onDateChanged,
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date Picker Button
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: const Icon(
              Icons.calendar_today,
              color: Color(0xFF3B82F6),
            ),
            title: Text(
              t.tasks.specificDate,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              widget.selectedDate != null
                  ? widget.selectedDate.toString().split(' ')[0]
                  : t.tasks.selectDateDescription,
            ),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: widget.selectedDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                widget.onDateChanged(picked);
                widget.errorNotifier.value = null;
              }
            },
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
        ValueListenableBuilder<String?>(
          valueListenable: widget.errorNotifier,
          builder: (context, error, child) {
            if (error == null) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                error,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 12,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
