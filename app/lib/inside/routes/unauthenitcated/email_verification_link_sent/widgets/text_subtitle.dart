import 'package:flutter/material.dart';

import '../../../../../outside/theme/theme.dart';
import '../../../../i18n/translations.g.dart';

class EmailVerificationLinkSent_Text_Subtitle extends StatelessWidget {
  const EmailVerificationLinkSent_Text_Subtitle({super.key});

  @override
  Widget build(BuildContext context) {
    final subtitle = context.t.emailVerificationLinkSent.subtitle;

    return Text(
      subtitle,
      textAlign: TextAlign.center,
      style: context.typography.bodyLarge?.copyWith(
        color: context.solidColors.onSurfaceVariant,
        height: 1.4,
      ),
    );
  }
}
