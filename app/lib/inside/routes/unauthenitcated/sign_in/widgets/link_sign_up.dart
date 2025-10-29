import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../outside/theme/theme.dart';
import '../../../../i18n/translations.g.dart';
import '../../../router.dart';

class SignIn_Link_SignUp extends StatelessWidget {
  const SignIn_Link_SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final question = context.t.signIn.signUp.question;
    final action = context.t.signIn.signUp.action;
    final spacing = context.tokens.spacing;
    final accent = context.colors.parentsPrimary;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: spacing.small),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: spacing.xSmall,
        runSpacing: spacing.xxSmall,
        children: [
          Text(
            question,
            style: context.typography.bodySmall?.copyWith(
              color: context.solidColors.onSurfaceVariant,
            ),
          ),
          TextButton(
            onPressed: () {
              context.router.navigate(const SignUp_Route());
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.small,
                vertical: spacing.xxSmall,
              ),
              foregroundColor: accent.end,
              textStyle: context.typography.button?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            child: Text(action),
          ),
        ],
      ),
    );
  }
}
