// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth_State _$Auth_StateFromJson(Map<String, dynamic> json) => Auth_State(
  status: $enumDecode(_$Auth_StatusEnumMap, json['status']),
  accessToken: json['accessToken'] as String?,
  appUser: json['appUser'] == null
      ? null
      : AppUser.fromJson(json['appUser'] as Map<String, dynamic>),
);

Map<String, dynamic> _$Auth_StateToJson(Auth_State instance) =>
    <String, dynamic>{
      'status': _$Auth_StatusEnumMap[instance.status]!,
      'accessToken': instance.accessToken,
      'appUser': instance.appUser,
    };

const _$Auth_StatusEnumMap = {
  Auth_Status.unauthenticated: 'unauthenticated',
  Auth_Status.authenticated: 'authenticated',
};
