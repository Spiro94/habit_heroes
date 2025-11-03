import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../outside/repositories/account_deletion/account_deletion_repository.dart';
import '../../../../../outside/theme/theme.dart';
import '../../../../blocs/account_deletion/bloc.dart';
import '../../../../blocs/account_deletion/event.dart';
import '../../../../blocs/account_deletion/state.dart';
import '../../../../i18n/translations.g.dart';
import '../../../router.dart';
import 'widgets/account_deletion_dialog.dart';

@RoutePage()
class SettingsList_Page extends StatelessWidget {
  const SettingsList_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountDeletion_Bloc(
        repository: context.read<AccountDeletion_Repository>(),
      )..add(const AccountDeletion_Event_Check()),
      child: const _SettingsList_Scaffold(),
    );
  }
}

class _SettingsList_Scaffold extends StatelessWidget {
  const _SettingsList_Scaffold();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: Text(
          t.settings.title,
          style: const TextStyle(color: Colors.black),
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
                const _SettingsList_Widget_AccountDeletionCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsList_Widget_AccountDeletionCard extends StatelessWidget {
  const _SettingsList_Widget_AccountDeletionCard();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return BlocBuilder<AccountDeletion_Bloc, AccountDeletion_State>(
      builder: (context, state) {
        final hasPending = state.hasPendingRequest;

        return _SettingsList_Widget_SettingCard(
          title: hasPending
              ? t.settings.accountDeletion.pendingTitle
              : t.settings.accountDeletion.title,
          subtitle: hasPending
              ? t.settings.accountDeletion.pendingSubtitle
              : t.settings.accountDeletion.subtitle,
          icon: hasPending ? Icons.pending_outlined : Icons.delete_forever,
          colorStart: hasPending
              ? context.solidColors.warning
              : context.solidColors.error,
          colorEnd: hasPending
              ? context.solidColors.warning.withValues(alpha: 0.8)
              : context.solidColors.error.withValues(alpha: 0.8),
          onTap: hasPending
              ? () {} // Disabled when pending
              : () {
                  showDialog<void>(
                    context: context,
                    builder: (dialogContext) => BlocProvider.value(
                      value: context.read<AccountDeletion_Bloc>(),
                      child: const SettingsList_Widget_AccountDeletionDialog(),
                    ),
                  );
                },
          trailingIcon: !hasPending,
        );
      },
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
    this.trailingIcon = true,
  });

  final String title;
  final String subtitle;
  final IconData? icon;
  final Color colorStart;
  final Color colorEnd;
  final VoidCallback onTap;
  final bool trailingIcon;

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
            if (trailingIcon)
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
