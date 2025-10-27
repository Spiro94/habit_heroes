import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../shared/mixins/logging.dart';
import '../../shared/models/kid.dart';
import '../blocs/auth/bloc.dart';
import 'authenticated/guard.dart';
import 'authenticated/home/page.dart';
import 'authenticated/parent_dashboard/page.dart';
import 'authenticated/parent_rewards/page.dart';
import 'authenticated/parents/kids/edit_kid/page.dart';
import 'authenticated/parents/kids/kids_list/page.dart';
import 'authenticated/parents/kids/router.dart';
import 'authenticated/parents/tasks/create_task/page.dart';
import 'authenticated/parents/tasks/router.dart';
import 'authenticated/parents/tasks/task_list/page.dart';
import 'authenticated/reset_password/page.dart';
import 'authenticated/router.dart';
import 'unauthenitcated/email_verification_link_sent/page.dart';
import 'unauthenitcated/forgot_password_flow/forgot_password/page.dart';
import 'unauthenitcated/forgot_password_flow/reset_password_link_sent/guard.dart';
import 'unauthenitcated/forgot_password_flow/reset_password_link_sent/page.dart';
import 'unauthenitcated/forgot_password_flow/router.dart';
import 'unauthenitcated/guard.dart';
import 'unauthenitcated/router.dart';
import 'unauthenitcated/sign_in/page.dart';
import 'unauthenitcated/sign_up/page.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class Routes_router extends RootStackRouter with SharedMixin_Logging {
  Routes_router({required this.authBloc, required super.navigatorKey});

  final Auth_Bloc authBloc;

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/anon',
      page: Unauthenticated_Routes.page,
      guards: [Unauthenticated_Guard(authBloc: authBloc)],
      children: [
        AutoRoute(path: 'sign-in', initial: true, page: SignIn_Route.page),
        AutoRoute(path: 'sign-in/sign-up', page: SignUp_Route.page),
        AutoRoute(
          path: 'sign-in/email-verification-link-sent',
          page: EmailVerificationLinkSent_Route.page,
        ),
        AutoRoute(
          path: 'sign-in/forgot-password-flow',
          page: ForgotPasswordFlow_Routes.page,
          children: [
            AutoRoute(path: 'forgot-password', page: ForgotPassword_Route.page),
            AutoRoute(
              path: 'reset-password-link-sent',
              page: ResetPasswordLinkSent_Route.page,
              guards: [ResetPasswordLinkSent_Guard()],
            ),
          ],
        ),
        RedirectRoute(path: '*', redirectTo: 'sign-in'),
      ],
    ),
    AutoRoute(
      path: '/',
      page: Authenticated_Routes.page,
      guards: [Authenticated_Guard(authBloc: authBloc)],
      children: [
        AutoRoute(initial: true, path: 'home', page: Home_Route.page),
        AutoRoute(path: 'home/reset-password', page: ResetPassword_Route.page),
        AutoRoute(
          page: ParentTasks_Routes.page,
          path: 'home/tasks',
          children: [
            AutoRoute(path: '', page: TaskList_Route.page),
            AutoRoute(path: 'create', page: CreateTask_Route.page),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          path: 'parent-dashboard',
          page: ParentDashboard_Route.page,
          children: [
            AutoRoute(path: 'rewards', page: ParentRewards_Route.page),
          ],
        ),
        AutoRoute(
          page: ParentKids_Routes.page,
          path: 'home/kids',
          children: [
            AutoRoute(path: '', page: KidList_Route.page),
            AutoRoute(path: 'edit', page: AddEditKid_Route.page),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),

        RedirectRoute(path: '*', redirectTo: 'home'),
      ],
    ),
    RedirectRoute(path: '*', redirectTo: '/home'),
  ];
}
