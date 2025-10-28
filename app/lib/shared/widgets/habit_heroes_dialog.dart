import 'package:flutter/material.dart';

import '../../outside/theme/theme.dart';

/// A reusable dialog component that matches the app's colorful design system.
///
/// This widget provides a vibrant, user-friendly dialog experience with:
/// - Gradient backgrounds based on dialog type
/// - Material Design 3 styling
/// - Colorful icons and accents
/// - Smooth animations
/// - Flexible content and action customization
///
/// Usage:
/// ```dart
/// HabitHeroes_Dialog(
///   title: 'Confirm Action',
///   body: const Text('Are you sure?'),
///   dialogType: HabitHeroesDialogType.info,
///   actions: [
///     HabitHeroesDialogAction(
///       label: 'Cancel',
///       onPressed: () => Navigator.pop(context),
///     ),
///     HabitHeroesDialogAction(
///       label: 'Confirm',
///       isPrimary: true,
///       onPressed: () => Navigator.pop(context, true),
///     ),
///   ],
/// )
/// ```
class HabitHeroes_Dialog extends StatelessWidget {
  /// Creates a [HabitHeroes_Dialog].
  const HabitHeroes_Dialog({
    required this.title,
    required this.body,
    required this.actions,
    this.dialogType = HabitHeroesDialogType.info,
    this.icon,
    super.key,
  });

  /// The title of the dialog
  final String title;

  /// The body content of the dialog
  final Widget body;

  /// The type of dialog (affects color scheme)
  final HabitHeroesDialogType dialogType;

  /// Optional icon to display in the header
  final IconData? icon;

  /// The actions (buttons) to display at the bottom of the dialog
  final List<HabitHeroesDialogAction> actions;

  AppColorGradient _getGradient(BuildContext context) {
    final colors = context.colors;
    return switch (dialogType) {
      HabitHeroesDialogType.info => colors.datePickerCyan,
      HabitHeroesDialogType.success => colors.taskCompletedGreen,
      HabitHeroesDialogType.error => AppColorGradient(
        start: context.solidColors.error,
        end: context.solidColors.error.withValues(alpha: 0.8),
      ),
      HabitHeroesDialogType.warning => AppColorGradient(
        start: context.solidColors.warning,
        end: context.solidColors.warning.withValues(alpha: 0.8),
      ),
    };
  }

  IconData _getDefaultIcon() {
    return switch (dialogType) {
      HabitHeroesDialogType.info => Icons.info_outline,
      HabitHeroesDialogType.success => Icons.check_circle_outline,
      HabitHeroesDialogType.error => Icons.error_outline,
      HabitHeroesDialogType.warning => Icons.warning_outlined,
    };
  }

  @override
  Widget build(BuildContext context) {
    final gradient = _getGradient(context);
    final displayIcon = icon ?? _getDefaultIcon();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400, minWidth: 280),
        decoration: BoxDecoration(
          color: context.solidColors.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context, gradient, displayIcon),
            _buildBody(context),
            _buildActions(context, gradient),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    AppColorGradient gradient,
    IconData displayIcon,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient.toLinearGradient(),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              shape: BoxShape.circle,
            ),
            child: Icon(displayIcon, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 14,
          color: context.solidColors.onSurface,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
        child: body,
      ),
    );
  }

  Widget _buildActions(BuildContext context, AppColorGradient gradient) {
    if (actions.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: actions.asMap().entries.map((entry) {
          final index = entry.key;
          final action = entry.value;
          return Padding(
            padding: EdgeInsets.only(left: index > 0 ? 12 : 0),
            child: _buildActionButton(context, action, gradient),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    HabitHeroesDialogAction action,
    AppColorGradient gradient,
  ) {
    if (action.isPrimary) {
      return Container(
        decoration: BoxDecoration(
          gradient: gradient.toLinearGradient(),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: gradient.toShadowColor(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: action.onPressed,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text(
                action.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action.onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: context.solidColors.border, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              action.label,
              style: TextStyle(
                color: context.solidColors.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      );
    }
  }
}

/// Represents an action (button) in a [HabitHeroes_Dialog]
class HabitHeroesDialogAction {
  /// Creates a [HabitHeroesDialogAction].
  const HabitHeroesDialogAction({
    required this.label,
    required this.onPressed,
    this.isPrimary = false,
  });

  /// The label text for the button
  final String label;

  /// The callback when the button is pressed
  final VoidCallback onPressed;

  /// Whether this is the primary action (styled as such)
  final bool isPrimary;
}

/// The type of dialog, affecting its color scheme and visual presentation
enum HabitHeroesDialogType {
  /// Information dialog (cyan color)
  info,

  /// Success dialog (green color)
  success,

  /// Error/destructive dialog (red color)
  error,

  /// Warning dialog (yellow color)
  warning,
}
