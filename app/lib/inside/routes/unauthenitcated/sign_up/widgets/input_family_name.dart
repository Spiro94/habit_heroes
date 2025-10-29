import 'package:flutter/material.dart';

import '../../../../../outside/theme/theme.dart';
import '../../../../../shared/widgets/colorful_text_field.dart';

class SignUp_Input_FamilyName extends StatelessWidget {
  const SignUp_Input_FamilyName({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    const label = 'Family Name';
    const hint = 'Enter a name for your new family';
    const emptyError = 'Family name is required';

    return ColorfulTextField(
      controller: controller,
      label: label,
      hint: hint,
      textCapitalization: TextCapitalization.words,
      gradient: context.colors.parentsPrimary,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return emptyError;
        }
        return null;
      },
    );
  }
}
