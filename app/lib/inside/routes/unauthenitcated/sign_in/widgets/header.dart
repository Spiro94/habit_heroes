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
        Image.asset('assets/icon/icon.png', width: 250, height: 250),
        Text(
          'Habit Heroes',
          style: context.typography.pageTitle?.copyWith(
            fontSize: 60,
            fontWeight: FontWeight.w800,
            foreground: Paint()
              ..shader = LinearGradient(
                colors: [accent.start, accent.end],
              ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: spacing.small),
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
