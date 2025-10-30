import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../outside/theme/theme.dart';
import 'widgets/header.dart';
import 'widgets/text_subtitle.dart';

@RoutePage()
class EmailVerificationLinkSent_Page extends StatelessWidget
    implements AutoRouteWrapper {
  const EmailVerificationLinkSent_Page({super.key});

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
      body: Container(
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
                  const EmailVerificationLinkSent_Header(),
                  SizedBox(height: spacing.large),
                  const EmailVerificationLinkSent_Text_Subtitle(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
