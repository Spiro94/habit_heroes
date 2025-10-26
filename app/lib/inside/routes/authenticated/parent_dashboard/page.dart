import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../i18n/translations.g.dart';

@RoutePage()
class ParentDashboard_Page extends StatelessWidget {
  const ParentDashboard_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.t.parentDashboard.title)),
      body: Center(child: Text(context.t.parentDashboard.welcome)),
    );
  }
}
