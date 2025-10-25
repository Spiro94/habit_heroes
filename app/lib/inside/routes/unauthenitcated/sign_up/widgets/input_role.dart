import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../../../../shared/models/app_user.dart';

class SignUp_Input_Role extends StatefulWidget {
  const SignUp_Input_Role({required this.onChanged, super.key});

  final ValueChanged<UserRole?> onChanged;

  @override
  State<SignUp_Input_Role> createState() => _SignUp_Input_RoleState();
}

class _SignUp_Input_RoleState extends State<SignUp_Input_Role> {
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return FSelect<UserRole>.rich(
      hint: 'Select a role',
      validator: (value) {
        if (value == null) {
          return 'Role is required';
        }
        return null;
      },
      onChange: widget.onChanged,
      format: (s) => s.name,
      children: const [
        FSelectItem(title: Text('Parent'), value: UserRole.parent),
        FSelectItem(title: Text('Kid'), value: UserRole.kid),
      ],
    );
  }
}
