import 'package:flutter/material.dart';

import '../../../../../../outside/theme/theme.dart';
import '../../../../../../shared/widgets/colorful_text_field.dart';
import '../../../../../i18n/translations.g.dart';
import '../../../../../util/validators.dart';

class ForgotPassword_Input_Email extends StatelessWidget {
  const ForgotPassword_Input_Email({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final label = context.t.forgotPassword.form.email.label;
    final hint = context.t.forgotPassword.form.email.hint;
    final emptyError = context.t.forgotPassword.form.email.error.empty;
    final invalidError = context.t.forgotPassword.form.email.error.invalid;

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
