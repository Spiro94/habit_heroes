import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../../util/breakpoints.dart';
import '../../router.dart';
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '¡Bienvenido a Habit Heroes!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                // Parent Button
                GestureDetector(
                  onTap: () => _handleParentAccess(context),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6366F1).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.admin_panel_settings,
                          size: 80,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Padres',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Gestiona tareas y recompensas',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Kids Button
                GestureDetector(
                  onTap: () => context.router.push(const KidsDashboard_Route()),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFEC4899), Color(0xFFF43F5E)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFEC4899).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.child_care,
                          size: 80,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Niños',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '¡Completa tus tareas y gana recompensas!',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
