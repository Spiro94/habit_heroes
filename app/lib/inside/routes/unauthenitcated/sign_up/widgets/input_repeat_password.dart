import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

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

    return FTextFormField.password(
      controller: controller,
      label: Text(label),
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
