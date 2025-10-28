import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../../../outside/theme/theme.dart';
import '../../../util/breakpoints.dart';
import '../../router.dart';
import '../../widgets/colorful_button.dart';
import '../../widgets/scaffold.dart';

@RoutePage()
class ParentDashboard_Page extends StatelessWidget {
  const ParentDashboard_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Routes_Scaffold(
      breakpointType: InsideUtil_BreakpointType.constrained,
      scaffold: FScaffold(
        header: FHeader.nested(
          title: const Text('Gestión de Tareas y Niños'),
          prefixes: [FHeaderAction.back(onPress: () => context.router.pop())],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ColorfulButton(
                gradient: context.colors.tasksBlue,
                label: 'Tareas',
                subtitle: 'Crea y gestiona tareas',
                icon: Icons.assignment,
                height: 180,
                labelFontSize: 24,
                subtitleFontSize: 14,
                iconSize: 64,
                onPressed: () =>
                    context.router.push(const ParentTasks_Routes()),
              ),
              const SizedBox(height: 24),
              ColorfulButton(
                gradient: context.colors.kidsManagementGreen,
                label: 'Niños',
                subtitle: 'Gestiona perfiles de tus hijos',
                icon: Icons.group,
                height: 180,
                labelFontSize: 24,
                subtitleFontSize: 14,
                iconSize: 64,
                onPressed: () =>
                    context.router.push(const ParentKids_Routes()),
              ),
              const SizedBox(height: 24),
              ColorfulButton(
                gradient: context.colors.pointsGold,
                label: 'Recompensas',
                subtitle: 'Gestiona recompensas y canjes',
                icon: Icons.card_giftcard,
                height: 180,
                labelFontSize: 24,
                subtitleFontSize: 14,
                iconSize: 64,
                onPressed: () =>
                    context.router.push(const ParentRewards_Routes()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
