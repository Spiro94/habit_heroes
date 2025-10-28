// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [AddEditKid_Page]
class AddEditKid_Route extends PageRouteInfo<AddEditKid_RouteArgs> {
  AddEditKid_Route({Key? key, Kid? kid, List<PageRouteInfo>? children})
    : super(
        AddEditKid_Route.name,
        args: AddEditKid_RouteArgs(key: key, kid: kid),
        initialChildren: children,
      );

  static const String name = 'AddEditKid_Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddEditKid_RouteArgs>(
        orElse: () => const AddEditKid_RouteArgs(),
      );
      return AddEditKid_Page(key: args.key, kid: args.kid);
    },
  );
}

class AddEditKid_RouteArgs {
  const AddEditKid_RouteArgs({this.key, this.kid});

  final Key? key;

  final Kid? kid;

  @override
  String toString() {
    return 'AddEditKid_RouteArgs{key: $key, kid: $kid}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddEditKid_RouteArgs) return false;
    return key == other.key && kid == other.kid;
  }

  @override
  int get hashCode => key.hashCode ^ kid.hashCode;
}

/// generated route for
/// [Authenticated_Router]
class Authenticated_Routes extends PageRouteInfo<void> {
  const Authenticated_Routes({List<PageRouteInfo>? children})
    : super(Authenticated_Routes.name, initialChildren: children);

  static const String name = 'Authenticated_Routes';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const Authenticated_Router();
    },
  );
}

/// generated route for
/// [CreateTask_Page]
class CreateTask_Route extends PageRouteInfo<CreateTask_RouteArgs> {
  CreateTask_Route({
    Key? key,
    String? taskScheduleId,
    List<PageRouteInfo>? children,
  }) : super(
         CreateTask_Route.name,
         args: CreateTask_RouteArgs(key: key, taskScheduleId: taskScheduleId),
         initialChildren: children,
       );

  static const String name = 'CreateTask_Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateTask_RouteArgs>(
        orElse: () => const CreateTask_RouteArgs(),
      );
      return CreateTask_Page(
        key: args.key,
        taskScheduleId: args.taskScheduleId,
      );
    },
  );
}

class CreateTask_RouteArgs {
  const CreateTask_RouteArgs({this.key, this.taskScheduleId});

  final Key? key;

  final String? taskScheduleId;

  @override
  String toString() {
    return 'CreateTask_RouteArgs{key: $key, taskScheduleId: $taskScheduleId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreateTask_RouteArgs) return false;
    return key == other.key && taskScheduleId == other.taskScheduleId;
  }

  @override
  int get hashCode => key.hashCode ^ taskScheduleId.hashCode;
}

/// generated route for
/// [EmailVerificationLinkSent_Page]
class EmailVerificationLinkSent_Route extends PageRouteInfo<void> {
  const EmailVerificationLinkSent_Route({List<PageRouteInfo>? children})
    : super(EmailVerificationLinkSent_Route.name, initialChildren: children);

  static const String name = 'EmailVerificationLinkSent_Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const EmailVerificationLinkSent_Page());
    },
  );
}

/// generated route for
/// [ForgotPasswordFlow_Router]
class ForgotPasswordFlow_Routes extends PageRouteInfo<void> {
  const ForgotPasswordFlow_Routes({List<PageRouteInfo>? children})
    : super(ForgotPasswordFlow_Routes.name, initialChildren: children);

  static const String name = 'ForgotPasswordFlow_Routes';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ForgotPasswordFlow_Router();
    },
  );
}

/// generated route for
/// [ForgotPassword_Page]
class ForgotPassword_Route extends PageRouteInfo<void> {
  const ForgotPassword_Route({List<PageRouteInfo>? children})
    : super(ForgotPassword_Route.name, initialChildren: children);

  static const String name = 'ForgotPassword_Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const ForgotPassword_Page());
    },
  );
}

/// generated route for
/// [Home_Page]
class Home_Route extends PageRouteInfo<void> {
  const Home_Route({List<PageRouteInfo>? children})
    : super(Home_Route.name, initialChildren: children);

  static const String name = 'Home_Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const Home_Page());
    },
  );
}

/// generated route for
/// [KidList_Page]
class KidList_Route extends PageRouteInfo<void> {
  const KidList_Route({List<PageRouteInfo>? children})
    : super(KidList_Route.name, initialChildren: children);

  static const String name = 'KidList_Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const KidList_Page();
    },
  );
}

/// generated route for
/// [KidsDashboard_Router]
class KidsDashboard_Route extends PageRouteInfo<void> {
  const KidsDashboard_Route({List<PageRouteInfo>? children})
    : super(KidsDashboard_Route.name, initialChildren: children);

  static const String name = 'KidsDashboard_Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const KidsDashboard_Router();
    },
  );
}

/// generated route for
/// [ParentDashboard_Page]
class ParentDashboard_Route extends PageRouteInfo<void> {
  const ParentDashboard_Route({List<PageRouteInfo>? children})
    : super(ParentDashboard_Route.name, initialChildren: children);

  static const String name = 'ParentDashboard_Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ParentDashboard_Page();
    },
  );
}

/// generated route for
/// [ParentKids_Router]
class ParentKids_Routes extends PageRouteInfo<void> {
  const ParentKids_Routes({List<PageRouteInfo>? children})
    : super(ParentKids_Routes.name, initialChildren: children);

  static const String name = 'ParentKids_Routes';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ParentKids_Router();
    },
  );
}

/// generated route for
/// [ParentRewards_Page]
class ParentRewards_Route extends PageRouteInfo<void> {
  const ParentRewards_Route({List<PageRouteInfo>? children})
    : super(ParentRewards_Route.name, initialChildren: children);

  static const String name = 'ParentRewards_Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ParentRewards_Page();
    },
  );
}

/// generated route for
/// [ParentTasks_Router]
class ParentTasks_Routes extends PageRouteInfo<void> {
  const ParentTasks_Routes({List<PageRouteInfo>? children})
    : super(ParentTasks_Routes.name, initialChildren: children);

  static const String name = 'ParentTasks_Routes';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ParentTasks_Router();
    },
  );
}

/// generated route for
/// [ResetPasswordLinkSent_Page]
class ResetPasswordLinkSent_Route
    extends PageRouteInfo<ResetPasswordLinkSent_RouteArgs> {
  ResetPasswordLinkSent_Route({
    String? email,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         ResetPasswordLinkSent_Route.name,
         args: ResetPasswordLinkSent_RouteArgs(email: email, key: key),
         rawQueryParams: {'email': email},
         initialChildren: children,
       );

  static const String name = 'ResetPasswordLinkSent_Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<ResetPasswordLinkSent_RouteArgs>(
        orElse: () => ResetPasswordLinkSent_RouteArgs(
          email: queryParams.optString('email'),
        ),
      );
      return WrappedRoute(
        child: ResetPasswordLinkSent_Page(email: args.email, key: args.key),
      );
    },
  );
}

class ResetPasswordLinkSent_RouteArgs {
  const ResetPasswordLinkSent_RouteArgs({this.email, this.key});

  final String? email;

  final Key? key;

  @override
  String toString() {
    return 'ResetPasswordLinkSent_RouteArgs{email: $email, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ResetPasswordLinkSent_RouteArgs) return false;
    return email == other.email && key == other.key;
  }

  @override
  int get hashCode => email.hashCode ^ key.hashCode;
}

/// generated route for
/// [ResetPassword_Page]
class ResetPassword_Route extends PageRouteInfo<void> {
  const ResetPassword_Route({List<PageRouteInfo>? children})
    : super(ResetPassword_Route.name, initialChildren: children);

  static const String name = 'ResetPassword_Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const ResetPassword_Page());
    },
  );
}

/// generated route for
/// [SignIn_Page]
class SignIn_Route extends PageRouteInfo<void> {
  const SignIn_Route({List<PageRouteInfo>? children})
    : super(SignIn_Route.name, initialChildren: children);

  static const String name = 'SignIn_Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const SignIn_Page());
    },
  );
}

/// generated route for
/// [SignUp_Page]
class SignUp_Route extends PageRouteInfo<void> {
  const SignUp_Route({List<PageRouteInfo>? children})
    : super(SignUp_Route.name, initialChildren: children);

  static const String name = 'SignUp_Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const SignUp_Page());
    },
  );
}

/// generated route for
/// [TaskList_Page]
class TaskList_Route extends PageRouteInfo<void> {
  const TaskList_Route({List<PageRouteInfo>? children})
    : super(TaskList_Route.name, initialChildren: children);

  static const String name = 'TaskList_Route';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TaskList_Page();
    },
  );
}

/// generated route for
/// [Unauthenticated_Router]
class Unauthenticated_Routes extends PageRouteInfo<void> {
  const Unauthenticated_Routes({List<PageRouteInfo>? children})
    : super(Unauthenticated_Routes.name, initialChildren: children);

  static const String name = 'Unauthenticated_Routes';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const Unauthenticated_Router();
    },
  );
}
