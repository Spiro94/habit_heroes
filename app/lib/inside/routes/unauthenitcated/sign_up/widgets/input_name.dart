import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class SignUp_Input_Name extends StatelessWidget {
  const SignUp_Input_Name({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    const label = 'Nombre';
    const hint = 'Ingresa tu nombre';
    const emptyError = 'El nombre es obligatorio';

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
