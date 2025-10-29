import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../outside/theme/theme.dart';
import 'widgets/header.dart';
import 'widgets/link_resend.dart';
import 'widgets/listener_status_change.dart';
import 'widgets/text_subtitle.dart';

@RoutePage()
class ResetPasswordLinkSent_Page extends StatelessWidget
    implements AutoRouteWrapper {
  const ResetPasswordLinkSent_Page({@QueryParam() this.email, super.key});

  final String? email;

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
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
      body: ResetPasswordLinkSent_Listener_StatusChange(
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
                    const ResetPasswordLinkSent_Header(),
                    SizedBox(height: spacing.large),
                    const ResetPasswordLinkSent_Text_Subtitle(),
                    SizedBox(height: spacing.large),
                    const Divider(),
                    SizedBox(height: spacing.medium),
                    const ResetPasswordLinkSent_Link_Resend(),
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
