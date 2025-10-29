import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../i18n/translations.g.dart';
import '../../../router.dart';

class EmailVerificationLinkSent_Header extends StatelessWidget {
  const EmailVerificationLinkSent_Header({super.key});

  @override
  Widget build(BuildContext context) {
    final title = context.t.emailVerificationLinkSent.title;

    return AppBar(
      title: Text(title),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.router.navigate(const SignIn_Route());
        },
      ),
      elevation: 0,
    );
  }
}
