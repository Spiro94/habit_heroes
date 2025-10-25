import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/models/app_user.dart';
import '../../blocs/auth/bloc.dart';
import '../../blocs/auth/state.dart';
import '../router.dart';

class Routes_Listener_AuthStatusChange extends StatelessWidget {
  const Routes_Listener_AuthStatusChange({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<Auth_Bloc, Auth_State>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        log('### Auth Status Change: ${state.status.name}');
        switch (state.status) {
          case Auth_Status.authenticated:
            if (state.appUser != null) {
              if (state.appUser!.role == UserRole.parent) {
                context.router.root.replaceAll([const Home_Route()]);
              } else if (state.appUser!.role == UserRole.kid) {
                context.router.root.replaceAll([const Home_Route()]);
              }
            }
          case Auth_Status.unauthenticated:
            context.router.root.replaceAll([const SignIn_Route()]);
        }
      },
      child: child,
    );
  }
}
