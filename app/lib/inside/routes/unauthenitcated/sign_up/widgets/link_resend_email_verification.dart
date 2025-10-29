import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../outside/theme/theme.dart';
import '../../../../../shared/widgets/habit_heroes_dialog.dart';
import '../../../../blocs/sign_up/bloc.dart';
import '../../../../blocs/sign_up/events.dart';
import '../../../../i18n/translations.g.dart';
import 'input_email.dart';

class SignUp_Link_ResendEmailVerification extends StatelessWidget {
  const SignUp_Link_ResendEmailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final question = context.t.signUp.resendEmailVerification.question;
    final action = context.t.signUp.resendEmailVerification.action;
    final spacing = context.tokens.spacing;
    final accent = context.colors.parentsPrimary;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: spacing.small),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: spacing.xSmall,
        runSpacing: spacing.xxSmall,
        children: [
          Text(
            question,
            style: context.typography.bodySmall?.copyWith(
              color: context.solidColors.onSurfaceVariant,
            ),
          ),
          TextButton(
            onPressed: () => _showDialog(context),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.small,
                vertical: spacing.xxSmall,
              ),
              foregroundColor: accent.end,
              textStyle: context.typography.button?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            child: Text(action),
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context) {
    final signUpBloc = context.read<SignUp_Bloc>();

    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => BlocProvider.value(
        value: signUpBloc,
        child: const _ResendDialog(),
      ),
    );
  }
}

class _ResendDialog extends StatefulWidget {
  const _ResendDialog();

  @override
  State<_ResendDialog> createState() => _ResendDialogState();
}

class _ResendDialogState extends State<_ResendDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController controller;
  bool _hasSubmitted = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    setState(() {
      _hasSubmitted = true;
    });

    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.of(context).pop();
    context.read<SignUp_Bloc>().add(
          SignUp_Event_ResendEmailVerificationLink(email: controller.text),
        );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.signUp.resendEmailVerification.dialog;

    return HabitHeroes_Dialog(
      icon: Icons.mark_email_unread_outlined,
      dialogType: HabitHeroesDialogType.info,
      title: t.title,
      body: Form(
        key: _formKey,
        autovalidateMode: _hasSubmitted
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: SignUp_Input_Email(controller: controller),
      ),
      actions: [
        HabitHeroesDialogAction(
          label: t.cancel,
          onPressed: () => Navigator.of(context).pop(),
        ),
        HabitHeroesDialogAction(
          label: t.submit.label,
          isPrimary: true,
          onPressed: _submit,
        ),
      ],
    );
  }
}
