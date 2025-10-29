import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../outside/theme/theme.dart';
import '../../../../i18n/translations.g.dart';
import '../../../router.dart';

class SignIn_Link_ForgotPassword extends StatelessWidget {
  const SignIn_Link_ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final question = context.t.signIn.forgotPassword.question;
    final accent = context.colors.parentsPrimary;
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          context.router.navigate(const ForgotPassword_Route());
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          textStyle: context.typography.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          foregroundColor: accent.end,
        ),
        child: Text(question),
      ),
    );
  }
}
