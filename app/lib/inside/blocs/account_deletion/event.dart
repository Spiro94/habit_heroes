import 'package:equatable/equatable.dart';

sealed class AccountDeletion_Event extends Equatable {
  const AccountDeletion_Event();

  @override
  List<Object?> get props => [];
}

class AccountDeletion_Event_Submit extends AccountDeletion_Event {
  const AccountDeletion_Event_Submit({required this.email, this.reason});

  final String email;
  final String? reason;

  @override
  List<Object?> get props => [email, reason];
}

class AccountDeletion_Event_Check extends AccountDeletion_Event {
  const AccountDeletion_Event_Check();
}
