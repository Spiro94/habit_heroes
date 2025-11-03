import 'package:equatable/equatable.dart';

enum AccountDeletion_Status { idle, loading, success, failure }

class AccountDeletion_State extends Equatable {
  const AccountDeletion_State({
    required this.status,
    this.errorMessage,
    this.hasPendingRequest = false,
  });

  const AccountDeletion_State.idle()
    : this(status: AccountDeletion_Status.idle);

  final AccountDeletion_Status status;
  final String? errorMessage;
  final bool hasPendingRequest;

  AccountDeletion_State copyWith({
    AccountDeletion_Status? status,
    String? Function()? errorMessage,
    bool? hasPendingRequest,
  }) => AccountDeletion_State(
    status: status ?? this.status,
    errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    hasPendingRequest: hasPendingRequest ?? this.hasPendingRequest,
  );

  @override
  List<Object?> get props => [status, errorMessage, hasPendingRequest];
}
