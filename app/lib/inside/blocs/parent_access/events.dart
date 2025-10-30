sealed class ParentAccess_Event {}

class ParentAccess_Event_CheckPinExists extends ParentAccess_Event {}

class ParentAccess_Event_CreatePin extends ParentAccess_Event {
  ParentAccess_Event_CreatePin({required this.pin});
  final String pin;
}

class ParentAccess_Event_VerifyPin extends ParentAccess_Event {
  ParentAccess_Event_VerifyPin({required this.pin});
  final String pin;
}

class ParentAccess_Event_UpdatePin extends ParentAccess_Event {
  ParentAccess_Event_UpdatePin({
    required this.currentPin,
    required this.newPin,
  });
  final String currentPin;
  final String newPin;
}
