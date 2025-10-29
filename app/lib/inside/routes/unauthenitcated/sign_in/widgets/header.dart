import 'package:flutter/material.dart';

import '../../../../../outside/theme/theme.dart';
import '../../../../i18n/translations.g.dart';

class SignIn_Header extends StatelessWidget {
  const SignIn_Header({super.key});

  @override
  Widget build(BuildContext context) {
    final title = context.t.signIn.title;

    final spacing = context.tokens.spacing;
    final accent = context.colors.parentsPrimary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
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
            Icons.auto_awesome,
            color: Colors.white,
            size: 44,
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
