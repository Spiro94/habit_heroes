import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class SignUp_Input_FamilyCode extends StatelessWidget {
  const SignUp_Input_FamilyCode({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    const label = 'Family Code';
    const hint = 'Enter the family code to join';
    const emptyError = 'Family code is required';

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
