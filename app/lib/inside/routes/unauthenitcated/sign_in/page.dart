import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../outside/repositories/auth/repository.dart';
import '../../../../outside/theme/theme.dart';
import '../../../blocs/sign_in/bloc.dart';
import 'widgets/form_sign_in.dart';
import 'widgets/header.dart';
import 'widgets/link_sign_up.dart';
import 'widgets/listener_status_change.dart';

@RoutePage()
class SignIn_Page extends StatelessWidget implements AutoRouteWrapper {
  const SignIn_Page({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SignIn_Bloc(authRepository: context.read<Auth_Repository>());
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
      body: SignIn_Listener_StatusChange(
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
                    const SignIn_Header(),
                    SizedBox(height: spacing.large),
                    const SignIn_Form_SignIn(),
                    SizedBox(height: spacing.large),
                    const SignIn_Link_SignUp(),
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
