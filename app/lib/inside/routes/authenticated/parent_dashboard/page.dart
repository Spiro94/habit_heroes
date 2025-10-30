import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../outside/theme/theme.dart';
import '../../router.dart';
import '../../widgets/colorful_button.dart';

@RoutePage()
class ParentDashboard_Page extends StatelessWidget {
  const ParentDashboard_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text(
          'Gestión de Tareas y Niños',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.router.push(const SettingsList_Route()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
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
      ),
    );
  }
}
