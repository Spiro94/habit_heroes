import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/models/app_user.dart';
import '../../blocs/auth/bloc.dart';
import '../../blocs/auth/state.dart';

class Auth_Listener_StatusChange extends StatelessWidget {
  const Auth_Listener_StatusChange({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<Auth_Bloc, Auth_State>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case Auth_Status.authenticated:
            if (state.appUser != null) {
              if (state.appUser!.role == UserRole.parent) {
                context.router.replaceNamed('/authenticated/parent');
              } else if (state.appUser!.role == UserRole.kid) {
                context.router.replaceNamed('/authenticated/kid');
              }
            }
          case Auth_Status.unauthenticated:
            context.router.replaceNamed('/unauthenticated');
        }
      },
      child: child,
    );
  }
}
