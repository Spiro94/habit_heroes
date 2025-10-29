import 'package:flutter/material.dart';

import '../../../../../outside/theme/theme.dart';
import '../../../../../shared/widgets/colorful_text_field.dart';
import '../../../../i18n/translations.g.dart';

class SignIn_Input_Password extends StatelessWidget {
  const SignIn_Input_Password({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final label = context.t.signIn.form.password.label;
    final emptyError = context.t.signIn.form.password.error.empty;

    return ColorfulTextField(
      controller: controller,
      label: label,
      obscureText: true,
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
