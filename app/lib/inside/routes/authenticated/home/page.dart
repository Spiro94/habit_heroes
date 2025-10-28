import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../../../outside/theme/theme.dart';
import '../../../util/breakpoints.dart';
import '../../router.dart';
import '../../widgets/colorful_button.dart';
import '../../widgets/scaffold.dart';
import 'widgets/pin_dialog.dart';

@RoutePage()
class Home_Page extends StatelessWidget implements AutoRouteWrapper {
  const Home_Page({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  Future<void> _handleParentAccess(BuildContext context) async {
    final verified = await showDialog<bool>(
      context: context,
      builder: (context) => const Home_Widget_PinDialog(),
    );

    if ((verified ?? false) && context.mounted) {
      await context.router.push(const ParentDashboard_Route());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Routes_Scaffold(
      breakpointType: InsideUtil_BreakpointType.constrained,
      scaffold: FScaffold(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                context.solidColors.background,
                context.solidColors.surfaceVariant.withValues(alpha: 0.3),
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icon/icon.png', width: 200, height: 200),
                  Text(
                    '¡Bienvenido a Habit Heroes!',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: context.solidColors.onBackground,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ColorfulButton(
                    gradient: context.colors.parentsPrimary,
                    label: 'Padres',
                    subtitle: 'Gestiona tareas y recompensas',
                    icon: Icons.admin_panel_settings,
                    onPressed: () => _handleParentAccess(context),
                  ),
                  const SizedBox(height: 24),
                  ColorfulButton(
                    gradient: context.colors.kidsPrimary,
                    label: 'Niños',
                    subtitle: '¡Completa tus tareas y gana recompensas!',
                    icon: Icons.child_care,
                    onPressed: () =>
                        context.router.push(const KidsDashboard_Route()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
