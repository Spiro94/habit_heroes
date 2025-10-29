import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../outside/repositories/auth/repository.dart';
import '../../../../outside/theme/theme.dart';
import '../../../blocs/sign_up/bloc.dart';
import 'widgets/form_sign_up.dart';
import 'widgets/header.dart';
import 'widgets/link_resend_email_verification.dart';
import 'widgets/listener_status_change.dart';

@RoutePage()
class SignUp_Page extends StatelessWidget implements AutoRouteWrapper {
  const SignUp_Page({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SignUp_Bloc(authRepository: context.read<Auth_Repository>());
      },
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.tokens.spacing;
    final backgroundGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        context.solidColors.background,
        context.colors.parentsPrimary.start.withValues(alpha: 0.05),
        context.colors.parentsPrimary.end.withValues(alpha: 0.15),
      ],
    );

    return Scaffold(
      backgroundColor: context.solidColors.background,
      body: SignUp_Listener_StatusChange(
        child: Container(
          decoration: BoxDecoration(gradient: backgroundGradient),
          alignment: Alignment.center,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spacing.large),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SignUp_Header(),
                    SizedBox(height: spacing.large),
                    const SignUp_Form_SignUp(),
                    SizedBox(height: spacing.large),
                    const Divider(),
                    SizedBox(height: spacing.medium),
                    const SignUp_Link_ResendEmailVerification(),
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
