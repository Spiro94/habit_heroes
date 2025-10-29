import 'package:flutter/material.dart';

import '../../../../../outside/theme/theme.dart';
import '../../../../../shared/widgets/colorful_text_field.dart';
import '../../../../i18n/translations.g.dart';

class SignUp_Input_RepeatPassword extends StatelessWidget {
  const SignUp_Input_RepeatPassword({
    required this.controller,
    required this.passwordController,
    super.key,
  });

  final TextEditingController controller;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final label = context.t.signUp.form.repeatPassword.label;
    final emptyError = context.t.signUp.form.repeatPassword.error.empty;
    final mismatchError = context.t.signUp.form.repeatPassword.error.mismatch;

    return ColorfulTextField(
      controller: controller,
      label: label,
      obscureText: true,
      gradient: context.colors.parentsPrimary,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return emptyError;
        }

        if (value != passwordController.text) {
          return mismatchError;
        }
        return null;
      },
    );
  }
}
