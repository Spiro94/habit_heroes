import 'package:flutter/material.dart';

import '../../../../../../../outside/theme/theme.dart';
import '../../../../../../../shared/models/kid.dart';
import '../../../../../../i18n/translations.g.dart';

class CreateTask_Widget_KidDropdown extends StatelessWidget {
  final Kid? selectedKid;
  final List<Kid> kids;
  final ValueChanged<Kid?> onChanged;

  const CreateTask_Widget_KidDropdown({
    required this.selectedKid,
    required this.kids,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          t.tasks.assignedTo,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<Kid>(
          initialValue: selectedKid,
          decoration: InputDecoration(
            hintText: t.tasks.assignedToHint,
            filled: true,
            fillColor: context.solidColors.surfaceVariant,
            prefixIcon: const Icon(Icons.person),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: context.colors.tasksBlue.start,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: context.solidColors.error,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          items: kids
              .map(
                (kid) => DropdownMenuItem(
                  value: kid,
                  child: Text(kid.name),
                ),
              )
              .toList(),
          onChanged: onChanged,
          validator: (value) {
            if (value == null) {
              return t.tasks.selectAKid;
            }
            return null;
          },
        ),
      ],
    );
  }
}
