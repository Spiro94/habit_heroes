import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../outside/theme/theme.dart';
import '../../../router.dart';

@RoutePage()
class SettingsList_Page extends StatelessWidget {
  const SettingsList_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text(
          'Configuración',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                _SettingsList_Widget_SettingCard(
                  title: 'Cambiar PIN Parental',
                  subtitle: 'Modifica el código de acceso parental',
                  icon: Icons.lock_outline,
                  colorStart: context.colors.datePickerCyan.start,
                  colorEnd: context.colors.datePickerCyan.end,
                  onTap: () {
                    context.router.push(const ChangePincode_Route());
                  },
                ),
                const SizedBox(height: 16),
                // Future settings cards can be added here
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsList_Widget_SettingCard extends StatelessWidget {
  const _SettingsList_Widget_SettingCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.colorStart,
    required this.colorEnd,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color colorStart;
  final Color colorEnd;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorStart, colorEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 32, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white.withValues(alpha: 0.7),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
