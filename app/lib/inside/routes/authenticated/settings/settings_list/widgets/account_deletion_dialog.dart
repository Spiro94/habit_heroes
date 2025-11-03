import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../outside/theme/theme.dart';
import '../../../../../../shared/widgets/all.dart';
import '../../../../../blocs/account_deletion/bloc.dart';
import '../../../../../blocs/account_deletion/event.dart';
import '../../../../../blocs/account_deletion/state.dart';
import '../../../../../i18n/translations.g.dart';
import '../../../../../util/validators.dart';

/// Dialog for requesting account deletion
class SettingsList_Widget_AccountDeletionDialog extends StatefulWidget {
  const SettingsList_Widget_AccountDeletionDialog({super.key});

  @override
  State<SettingsList_Widget_AccountDeletionDialog> createState() =>
      _SettingsList_Widget_AccountDeletionDialogState();
}

class _SettingsList_Widget_AccountDeletionDialogState
    extends State<SettingsList_Widget_AccountDeletionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final bloc = context.read<AccountDeletion_Bloc>();
      bloc.add(
        AccountDeletion_Event_Submit(
          email: _emailController.text.trim(),
          reason: _reasonController.text.trim().isEmpty
              ? null
              : _reasonController.text.trim(),
        ),
      );
    }
  }

  void _showSuccessDialog(BuildContext context, Translations t) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => HabitHeroes_Dialog(
        title: t.settings.accountDeletion.dialog.success.title,
        dialogType: HabitHeroesDialogType.success,
        icon: Icons.check_circle_outline,
        body: Text(
          t.settings.accountDeletion.dialog.success.message,
          textAlign: TextAlign.center,
        ),
        actions: [
          HabitHeroesDialogAction(
            label: 'OK',
            isPrimary: true,
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return BlocConsumer<AccountDeletion_Bloc, AccountDeletion_State>(
      listener: (context, state) {
        if (state.status == AccountDeletion_Status.success) {
          // Close the form dialog first
          Navigator.of(context).pop();

          // Trigger a recheck to update the card
          context.read<AccountDeletion_Bloc>().add(
                const AccountDeletion_Event_Check(),
              );

          // Show success dialog synchronously
          _showSuccessDialog(context, t);
        } else if (state.status == AccountDeletion_Status.failure) {
          // Show error as a snackbar or inline - keeping dialog open
          final errorMsg =
              state.errorMessage ??
              t.settings.accountDeletion.dialog.error.generic;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: context.solidColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == AccountDeletion_Status.loading;

        return HabitHeroes_Dialog(
          title: t.settings.accountDeletion.dialog.title,
          dialogType: HabitHeroesDialogType.warning,
          icon: Icons.delete_forever,
          body: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  t.settings.accountDeletion.dialog.message,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ColorfulTextField(
                  label: t.settings.accountDeletion.dialog.form.email.label,
                  hint: t.settings.accountDeletion.dialog.form.email.hint,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  gradient: AppColorGradient(
                    start: context.solidColors.warning,
                    end: context.solidColors.warning.withValues(alpha: 0.8),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return t
                          .settings
                          .accountDeletion
                          .dialog
                          .form
                          .email
                          .error
                          .empty;
                    }
                    if (!InsideUtil_Validators.isEmailValid(value.trim())) {
                      return t
                          .settings
                          .accountDeletion
                          .dialog
                          .form
                          .email
                          .error
                          .invalid;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ColorfulTextField(
                  label: t.settings.accountDeletion.dialog.form.reason.label,
                  hint: t.settings.accountDeletion.dialog.form.reason.hint,
                  controller: _reasonController,
                  maxLines: 3,
                  gradient: AppColorGradient(
                    start: context.solidColors.warning,
                    end: context.solidColors.warning.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            if (!isLoading)
              HabitHeroesDialogAction(
                label: t.settings.accountDeletion.dialog.cancel,
                onPressed: () => Navigator.of(context).pop(),
              ),
            HabitHeroesDialogAction(
              label: isLoading
                  ? 'Enviando...'
                  : t.settings.accountDeletion.dialog.submit,
              isPrimary: true,
              onPressed: isLoading ? () {} : _handleSubmit,
            ),
          ],
        );
      },
    );
  }
}
