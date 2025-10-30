import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../outside/repositories/parent_access/repository.dart';
import '../../../../outside/theme/theme.dart';
import '../../../blocs/auth/bloc.dart';
import '../../../blocs/auth/events.dart';
import '../../../blocs/parent_access/bloc.dart';
import '../../router.dart';
import '../../widgets/colorful_button.dart';
import 'widgets/pin_dialog.dart';

@RoutePage()
class Home_Page extends StatelessWidget implements AutoRouteWrapper {
  const Home_Page({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    final parentAccessRepository =
        RepositoryProvider.of<ParentAccess_Repository>(context);

    return BlocProvider(
      create: (context) =>
          ParentAccess_Bloc(parentAccessRepository: parentAccessRepository),
      child: this,
    );
  }

  Future<void> _handleParentAccess(BuildContext context) async {
    final bloc = context.read<ParentAccess_Bloc>();

    final verified = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) =>
          BlocProvider.value(value: bloc, child: const Home_Widget_PinDialog()),
    );

    if ((verified ?? false) && context.mounted) {
      await context.router.push(const ParentDashboard_Route());
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = context.colors.parentsPrimary;
    final isTablet = MediaQuery.sizeOf(context).shortestSide >= 600;
    return Scaffold(
      appBar: isTablet
          ? AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<Auth_Bloc>().add(Auth_Event_SignOut());
                  },
                  icon: const Icon(Icons.logout_rounded, color: Colors.black),
                ),
              ],
            )
          : null,
      body: SafeArea(
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
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isTablet)
                      Image.asset(
                        'assets/icon/icon.png',
                        width: 200,
                        height: 200,
                      )
                    else
                      Stack(
                        children: [
                          SizedBox(
                            width: double.maxFinite,
                            child: Image.asset(
                              'assets/icon/icon.png',
                              width: isTablet ? 200 : 150,
                              height: isTablet ? 200 : 150,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                context.read<Auth_Bloc>().add(
                                  Auth_Event_SignOut(),
                                );
                              },
                              icon: const Icon(
                                Icons.logout_rounded,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    Text(
                      '¡Bienvenido a \nHabit Heroes!',
                      style: context.typography.pageTitle?.copyWith(
                        fontSize: 48,
                        fontWeight: FontWeight.w800,
                        foreground: Paint()
                          ..shader = LinearGradient(
                            colors: [accent.start, accent.end],
                          ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                      ),
                    ),
                    const SizedBox(height: 32),
                    ColorfulButton(
                      gradient: context.colors.parentsPrimary,
                      label: 'Padres',
                      subtitle: 'Gestiona tareas y recompensas',
                      icon: Icons.admin_panel_settings_rounded,
                      onPressed: () => _handleParentAccess(context),
                    ),
                    const SizedBox(height: 24),
                    ColorfulButton(
                      gradient: context.colors.kidsPrimary,
                      label: 'Héroes',
                      subtitle: '¡Completa tus tareas y gana recompensas!',
                      icon: Icons.child_care_rounded,
                      onPressed: () =>
                          context.router.push(const KidsDashboard_Route()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
