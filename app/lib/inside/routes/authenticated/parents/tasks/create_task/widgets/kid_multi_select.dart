import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../../outside/theme/theme.dart';
import '../../../../../../../shared/models/kid.dart';
import '../../../../../../i18n/translations.g.dart';

class CreateTask_Widget_KidMultiSelect extends StatelessWidget {
  final List<Kid> selectedKids;
  final List<Kid> allKids;
  final ValueChanged<List<Kid>> onChanged;

  const CreateTask_Widget_KidMultiSelect({
    required this.selectedKids,
    required this.allKids,
    required this.onChanged,
    super.key,
  });

  void _toggleKid(Kid kid) {
    final updatedKids = List<Kid>.from(selectedKids);
    if (selectedKids.any((k) => k.id == kid.id)) {
      updatedKids.removeWhere((k) => k.id == kid.id);
    } else {
      updatedKids.add(kid);
    }
    onChanged(updatedKids);
  }

  void _removeKid(Kid kid) {
    final updatedKids = List<Kid>.from(selectedKids);
    updatedKids.removeWhere((k) => k.id == kid.id);
    onChanged(updatedKids);
  }

  @override
  Widget build(BuildContext context) {
    // Filter out already selected kids from the available list
    final availableKids = allKids
        .where((kid) => !selectedKids.any((selected) => selected.id == kid.id))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.tasks.assignedTo,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Gap(8),

        // Show selected kids as chips
        if (selectedKids.isNotEmpty) ...[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedKids.map((kid) {
              return Chip(
                label: Text(kid.name),
                deleteIcon: const Icon(Icons.close, size: 18),
                onDeleted: () => _removeKid(kid),
                backgroundColor: context.colors.tasksBlue.start
                    .withValues(alpha: 0.1),
                labelStyle: TextStyle(
                  color: context.colors.tasksBlue.start,
                  fontWeight: FontWeight.w500,
                ),
                deleteIconColor: context.colors.tasksBlue.start,
              );
            }).toList(),
          ),
          const Gap(12),
        ],

        // Show available kids with checkboxes
        Container(
          decoration: BoxDecoration(
            color: context.solidColors.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: context.solidColors.divider,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              if (availableKids.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    selectedKids.isEmpty
                        ? t.tasks.noKidsAvailable
                        : t.tasks.allKidsSelected,
                    style: TextStyle(
                      color: context.solidColors.onSurfaceVariant,
                      fontSize: 14,
                    ),
                  ),
                )
              else
                ...availableKids.asMap().entries.map((entry) {
                  final index = entry.key;
                  final kid = entry.value;
                  final isLast = index == availableKids.length - 1;

                  return Column(
                    children: [
                      InkWell(
                        onTap: () => _toggleKid(kid),
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: context.colors.tasksBlue.start,
                              ),
                              const Gap(12),
                              Expanded(
                                child: Text(
                                  kid.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Checkbox(
                                value: false, // Unselected
                                onChanged: (_) => _toggleKid(kid),
                                activeColor:
                                    context.colors.tasksBlue.start,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (!isLast)
                        Divider(
                          height: 1,
                          color: context.solidColors.divider,
                          indent: 16,
                          endIndent: 16,
                        ),
                    ],
                  );
                }),
            ],
          ),
        ),

        // Validation message
        if (selectedKids.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 12),
            child: Text(
              t.tasks.selectAtLeastOneKid,
              style: TextStyle(
                color: context.solidColors.error,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
