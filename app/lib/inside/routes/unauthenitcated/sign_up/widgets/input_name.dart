import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class SignUp_Input_Name extends StatelessWidget {
  const SignUp_Input_Name({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final label = 'Display Name'; // TODO: add to translations
    final hint = 'Enter your display name';
    final emptyError = 'Display name is required';

    return FTextFormField(
      controller: controller,
      label: Text(label),
      hint: hint,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return emptyError;
        }
        return null;
      },
    );
  }
}
