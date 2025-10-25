import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class SignUp_Input_FamilyName extends StatelessWidget {
  const SignUp_Input_FamilyName({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    const label = 'Family Name';
    const hint = 'Enter a name for your new family';
    const emptyError = 'Family name is required';

    return FTextFormField(
      controller: controller,
      label: const Text(label),
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
