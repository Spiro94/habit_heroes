import 'package:flutter/material.dart';

import 'habit_heroes_dialog.dart';

/// Helper functions for showing common dialog types
class HabitHeroesDialogHelpers {
  /// Shows a confirmation dialog with Yes/No actions
  ///
  /// Returns `true` if user confirms, `false` if user cancels
  static Future<bool?> showConfirmation(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirmar',
    String cancelLabel = 'Cancelar',
    HabitHeroesDialogType type = HabitHeroesDialogType.info,
    IconData? icon,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => HabitHeroes_Dialog(
        title: title,
        dialogType: type,
        icon: icon,
        body: Text(message),
        actions: [
          HabitHeroesDialogAction(
            label: cancelLabel,
            onPressed: () => Navigator.pop(context, false),
          ),
          HabitHeroesDialogAction(
            label: confirmLabel,
            isPrimary: true,
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
  }

  /// Shows an alert/info dialog with a single OK button
  ///
  /// Returns `true` when user dismisses the dialog
  static Future<bool?> showAlert(
    BuildContext context, {
    required String title,
    required String message,
    String okLabel = 'Aceptar',
    HabitHeroesDialogType type = HabitHeroesDialogType.info,
    IconData? icon,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => HabitHeroes_Dialog(
        title: title,
        dialogType: type,
        icon: icon,
        body: Text(message),
        actions: [
          HabitHeroesDialogAction(
            label: okLabel,
            isPrimary: true,
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
  }

  /// Shows a success dialog
  static Future<bool?> showSuccess(
    BuildContext context, {
    required String title,
    required String message,
    String okLabel = 'Aceptar',
  }) {
    return showAlert(
      context,
      title: title,
      message: message,
      okLabel: okLabel,
      type: HabitHeroesDialogType.success,
      icon: Icons.check_circle_outline,
    );
  }

  /// Shows an error dialog
  static Future<bool?> showError(
    BuildContext context, {
    required String title,
    required String message,
    String okLabel = 'Aceptar',
  }) {
    return showAlert(
      context,
      title: title,
      message: message,
      okLabel: okLabel,
      type: HabitHeroesDialogType.error,
      icon: Icons.error_outline,
    );
  }

  /// Shows a warning dialog
  static Future<bool?> showWarning(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Continuar',
    String cancelLabel = 'Cancelar',
  }) {
    return showConfirmation(
      context,
      title: title,
      message: message,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
      type: HabitHeroesDialogType.warning,
      icon: Icons.warning_outlined,
    );
  }

  /// Shows a delete confirmation dialog
  ///
  /// Returns `true` if user confirms deletion, `false` otherwise
  static Future<bool?> showDeleteConfirmation(
    BuildContext context, {
    required String itemName,
    String? additionalMessage,
  }) {
    final message = additionalMessage != null
        ? '¿Está seguro de que desea eliminar $itemName?\n\n$additionalMessage'
        : '¿Está seguro de que desea eliminar $itemName?';

    return showConfirmation(
      context,
      title: 'Eliminar $itemName',
      message: message,
      confirmLabel: 'Eliminar',
      cancelLabel: 'Cancelar',
      type: HabitHeroesDialogType.error,
      icon: Icons.delete_outline,
    );
  }
}
