import 'package:flutter/material.dart';

import '../../../../../outside/theme/theme.dart';
import '../../../../../shared/widgets/colorful_text_field.dart';
import '../../../../i18n/translations.g.dart';
import '../../../../util/validators.dart';

class SignIn_Input_Email extends StatelessWidget {
  const SignIn_Input_Email({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final label = context.t.signIn.form.email.label;
    final hint = context.t.signIn.form.email.hint;
    final emptyError = context.t.signIn.form.email.error.empty;
    final invalidError = context.t.signIn.form.email.error.invalid;

    return ColorfulTextField(
      controller: controller,
      label: label,
      hint: hint,
      keyboardType: TextInputType.emailAddress,
      gradient: context.colors.parentsPrimary,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return emptyError;
        }

        if (!InsideUtil_Validators.isEmailValid(value)) {
          return invalidError;
        }
        return null;
      },
    );
  }
}
