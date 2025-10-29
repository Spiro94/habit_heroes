import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../outside/theme/theme.dart';
import '../../../../../blocs/reset_password/bloc.dart';
import '../../../../../blocs/reset_password/events.dart';
import '../../../../../i18n/translations.g.dart';

class ResetPasswordLinkSent_Link_Resend extends StatelessWidget {
  const ResetPasswordLinkSent_Link_Resend({super.key});

  @override
  Widget build(BuildContext context) {
    final question = context.t.resetPasswordLinkSent.resend.question;
    final action = context.t.resetPasswordLinkSent.resend.action;
    final email = context.routeData.queryParams.getString('email');
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
              context.read<ResetPassword_Bloc>().add(
                    ResetPassword_Event_ResendResetPasswordLink(email: email),
                  );
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
