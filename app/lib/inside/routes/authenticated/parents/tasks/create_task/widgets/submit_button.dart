import 'package:flutter/material.dart';

import '../../../../../../../outside/theme/theme.dart';
import '../../../../../../i18n/translations.g.dart';

class CreateTask_Widget_SubmitButton extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onPressed;

  const CreateTask_Widget_SubmitButton({
    required this.isEditing,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colors.tasksBlue.start,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Text(
          isEditing ? t.tasks.updateButton : t.tasks.createButton,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
