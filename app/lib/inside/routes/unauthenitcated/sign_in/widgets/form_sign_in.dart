import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../outside/theme/theme.dart';
import '../../../../../shared/mixins/logging.dart';
import '../../../../blocs/sign_in/bloc.dart';
import '../../../../blocs/sign_in/events.dart';
import 'button_submit.dart';
import 'input_email.dart';
import 'input_password.dart';
import 'link_forgot_password.dart';

class SignIn_Form_SignIn extends StatefulWidget with SharedMixin_Logging {
  const SignIn_Form_SignIn({super.key});

  @override
  State<SignIn_Form_SignIn> createState() => _SignIn_Form_SignInState();
}

class _SignIn_Form_SignInState extends State<SignIn_Form_SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool _hasSubmittedBefore = false;

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  void _refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();

    emailController.addListener(_refresh);
    passwordController.addListener(_refresh);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();
    widget.log.info('submitting form');

    setState(() {
      _hasSubmittedBefore = true;
    });

    if (!_formKey.currentState!.validate()) {
      widget.log.warning('form not valid');
      // short-circuit if not valid
      return;
    }
    widget.log.info('form valid');

    context.read<SignIn_Bloc>().add(
      SignIn_Event_SignIn(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.tokens.spacing;
    final cardGradient = context.colors.parentsPrimary;

    return Container(
      padding: EdgeInsets.all(spacing.large),
      decoration: BoxDecoration(
        color: context.solidColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.solidColors.border.withValues(alpha: 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: cardGradient.toShadowColor(0.2),
            blurRadius: 30,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: _hasSubmittedBefore
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SignIn_Input_Email(controller: emailController),
            SizedBox(height: spacing.medium),
            SignIn_Input_Password(
              controller: passwordController,
              onEditingComplete: _onSubmit,
            ),
            SizedBox(height: spacing.small),
            const SignIn_Link_ForgotPassword(),
            SizedBox(height: spacing.small),
            SignIn_Button_Submit(onSubmit: _onSubmit),
          ],
        ),
      ),
    );
  }
}
