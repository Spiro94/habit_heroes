import '../../../shared/models/app_user.dart';

abstract class SignUp_Event {}

class SignUp_Event_SignUp extends SignUp_Event {
  SignUp_Event_SignUp({
    required this.email,
    required this.password,
    required this.displayName,
    required this.role,
    required this.isJoiningFamily,
    this.familyCode,
    this.familyName,
  });

  final String email;
  final String password;
  final String displayName;
  final UserRole role;
  final bool isJoiningFamily;
  final String? familyCode;
  final String? familyName;
}

class SignUp_Event_ResendEmailVerificationLink extends SignUp_Event {
  SignUp_Event_ResendEmailVerificationLink({required this.email});

  final String email;
}
