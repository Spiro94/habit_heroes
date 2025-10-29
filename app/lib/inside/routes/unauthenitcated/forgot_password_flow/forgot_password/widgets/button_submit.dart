import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../outside/theme/theme.dart';
import '../../../../../blocs/reset_password/bloc.dart';
import '../../../../../blocs/reset_password/state.dart';
import '../../../../../i18n/translations.g.dart';

class ForgotPassword_Button_Submit extends StatelessWidget {
  const ForgotPassword_Button_Submit({required this.onSubmit, super.key});

  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final label = context.t.forgotPassword.form.submit.label;
    final isLoading = context.select(
      (ResetPassword_Bloc bloc) =>
          bloc.state.status ==
          ResetPassword_Status.sendResetPasswordLinkInProgress,
    );
    final gradient = context.colors.parentsPrimary;
    final colors = [gradient.start, gradient.end];
    final disabledColors = colors
        .map((color) => color.withValues(alpha: 0.6))
        .toList(growable: false);
    final textStyle =
        context.typography.primaryTextTheme.labelLarge?.copyWith(
          color: context.solidColors.onPrimary,
        ) ??
        TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: context.solidColors.onPrimary,
        );

    final borderRadius = BorderRadius.circular(16);

    return IgnorePointer(
      ignoring: isLoading,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isLoading ? 0.8 : 1,
        child: Material(
          color: Colors.transparent,
          borderRadius: borderRadius,
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isLoading ? disabledColors : colors,
                begin: gradient.begin,
                end: gradient.alignment,
              ),
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  color: gradient.toShadowColor(0.35),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: InkWell(
              borderRadius: borderRadius,
              onTap: isLoading ? null : onSubmit,
              child: SizedBox(
                height: 56,
                child: Center(
                  child: isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              context.solidColors.onPrimary,
                            ),
                          ),
                        )
                      : Text(label, style: textStyle),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
