import 'package:flutter/material.dart';

import '../../../../../../../outside/theme/theme.dart';
import '../../../../../../../shared/widgets/all.dart';
import '../../../../../../i18n/translations.g.dart';

class CreateTask_Widget_TitleField extends StatelessWidget {
  final TextEditingController controller;

  const CreateTask_Widget_TitleField({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ColorfulTextField(
      label: t.tasks.titleLabel,
      hint: t.tasks.titleHint,
      controller: controller,
      gradient: context.colors.tasksBlue,
      textCapitalization: TextCapitalization.words,
      prefixIcon: const Icon(Icons.task),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return t.tasks.titleRequired;
        }
        return null;
      },
    );
  }
}
