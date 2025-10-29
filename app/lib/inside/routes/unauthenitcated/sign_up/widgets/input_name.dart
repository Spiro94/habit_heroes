import 'package:flutter/material.dart';

import '../../../../../outside/theme/theme.dart';
import '../../../../../shared/widgets/colorful_text_field.dart';

class SignUp_Input_Name extends StatelessWidget {
  const SignUp_Input_Name({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    const label = 'Nombre';
    const hint = 'Ingresa tu nombre';
    const emptyError = 'El nombre es obligatorio';

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
