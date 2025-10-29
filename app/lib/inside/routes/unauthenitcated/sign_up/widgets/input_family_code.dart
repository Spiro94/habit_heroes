import 'package:flutter/material.dart';

import '../../../../../outside/theme/theme.dart';
import '../../../../../shared/widgets/colorful_text_field.dart';

class SignUp_Input_FamilyCode extends StatelessWidget {
  const SignUp_Input_FamilyCode({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    const label = 'Family Code';
    const hint = 'Enter the family code to join';
    const emptyError = 'Family code is required';

    return ColorfulTextField(
      controller: controller,
      label: label,
      hint: hint,
      textCapitalization: TextCapitalization.characters,
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
