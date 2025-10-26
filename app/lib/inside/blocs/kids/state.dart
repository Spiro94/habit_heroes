import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../shared/models/kid.dart';

part 'state.g.dart';

enum Kids_Status {
  initial,
  loading,
  loaded,
  error,
}

@JsonSerializable()
class Kids_State extends Equatable {
  const Kids_State({
    required this.status,
    required this.kids,
    this.errorMessage,
  });

  factory Kids_State.initial() => const Kids_State(
        status: Kids_Status.initial,
        kids: [],
      );

  final Kids_Status status;
  final List<Kid> kids;
  final String? errorMessage;

  Kids_State copyWith({
    Kids_Status? status,
    List<Kid>? kids,
    String? Function()? setErrorMessage,
  }) {
    return Kids_State(
      status: status ?? this.status,
      kids: kids ?? this.kids,
      errorMessage:
          setErrorMessage != null ? setErrorMessage() : errorMessage,
    );
  }

  factory Kids_State.fromJson(Map<String, dynamic> json) =>
      _$Kids_StateFromJson(json);

  Map<String, dynamic> toJson() => _$Kids_StateToJson(this);

  @override
  List<Object?> get props => [status, kids, errorMessage];
}
