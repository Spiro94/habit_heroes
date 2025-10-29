import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../outside/theme/theme.dart';
import '../../../../../i18n/translations.g.dart';
import '../../../../router.dart';

class ResetPasswordLinkSent_Header extends StatelessWidget {
  const ResetPasswordLinkSent_Header({super.key});

  @override
  Widget build(BuildContext context) {
    final title = context.t.resetPasswordLinkSent.title;
    final spacing = context.tokens.spacing;
    final accent = context.colors.parentsPrimary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: context.solidColors.onBackground,
            onPressed: () {
              context.router.navigate(const SignIn_Route());
            },
          ),
        ),
        SizedBox(height: spacing.medium),
        Center(
          child: Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: accent.toLinearGradient(),
              boxShadow: [
                BoxShadow(
                  color: accent.toShadowColor(0.35),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: const Icon(
              Icons.mark_email_read_outlined,
              color: Colors.white,
              size: 44,
            ),
          ),
        ),
        SizedBox(height: spacing.large),
        Text(
          title,
          style: context.typography.pageTitle?.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: context.solidColors.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
