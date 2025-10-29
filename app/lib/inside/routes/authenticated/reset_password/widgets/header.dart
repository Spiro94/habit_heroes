import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../i18n/translations.g.dart';
import '../../../router.dart';

class ResetPassword_Header extends StatelessWidget {
  const ResetPassword_Header({super.key});

  @override
  Widget build(BuildContext context) {
    final title = context.t.resetPassword.title;

    return AppBar(
      title: Text(title),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.router.navigate(const Home_Route());
        },
      ),
      elevation: 0,
    );
  }
}
