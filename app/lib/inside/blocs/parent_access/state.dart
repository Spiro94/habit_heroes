import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

enum ParentAccess_Status {
  initial,
  checking,
  checked,
  checkError,
  creating,
  createSuccess,
  createError,
  verifying,
  verifySuccess,
  verifyError,
  updating,
  updateSuccess,
  updateError,
}

@JsonSerializable()
class ParentAccess_State extends Equatable {
  const ParentAccess_State({
    required this.status,
    this.errorMessage,
    this.pinExists,
  });

  final ParentAccess_Status status;
  final String? errorMessage;
  final bool? pinExists;

  ParentAccess_State copyWith({
    ParentAccess_Status? status,
    String? errorMessage,
    bool? pinExists,
  }) {
    return ParentAccess_State(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      pinExists: pinExists ?? this.pinExists,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        pinExists,
      ];

  // coverage:ignore-start
  factory ParentAccess_State.fromJson(Map<String, dynamic> json) =>
      _$ParentAccess_StateFromJson(json);

  Map<String, dynamic> toJson() => _$ParentAccess_StateToJson(this);
  // coverage:ignore-end
}
