import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../shared/models/app_user.dart';
import '../../../shared/models/family.dart';

part 'state.g.dart';

enum Auth_Status { unauthenticated, authenticated }

@JsonSerializable()
class Auth_State extends Equatable {
  const Auth_State({
    required this.status,
    required this.accessToken,
    this.appUser,
    this.family,
  });

  final Auth_Status status;
  final String? accessToken;
  final AppUser? appUser;
  final Family? family;

  @override
  List<Object?> get props => [status, accessToken, appUser, family];

  // coverage:ignore-start
  factory Auth_State.fromJson(Map<String, dynamic> json) =>
      _$Auth_StateFromJson(json);

  Map<String, dynamic> toJson() => _$Auth_StateToJson(this);
  // coverage:ignore-end
}
