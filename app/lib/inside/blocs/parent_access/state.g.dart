// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParentAccess_State _$ParentAccess_StateFromJson(Map<String, dynamic> json) =>
    ParentAccess_State(
      status: $enumDecode(_$ParentAccess_StatusEnumMap, json['status']),
      errorMessage: json['errorMessage'] as String?,
      pinExists: json['pinExists'] as bool?,
    );

Map<String, dynamic> _$ParentAccess_StateToJson(ParentAccess_State instance) =>
    <String, dynamic>{
      'status': _$ParentAccess_StatusEnumMap[instance.status]!,
      'errorMessage': instance.errorMessage,
      'pinExists': instance.pinExists,
    };

const _$ParentAccess_StatusEnumMap = {
  ParentAccess_Status.initial: 'initial',
  ParentAccess_Status.checking: 'checking',
  ParentAccess_Status.checked: 'checked',
  ParentAccess_Status.checkError: 'checkError',
  ParentAccess_Status.creating: 'creating',
  ParentAccess_Status.createSuccess: 'createSuccess',
  ParentAccess_Status.createError: 'createError',
  ParentAccess_Status.verifying: 'verifying',
  ParentAccess_Status.verifySuccess: 'verifySuccess',
  ParentAccess_Status.verifyError: 'verifyError',
  ParentAccess_Status.updating: 'updating',
  ParentAccess_Status.updateSuccess: 'updateSuccess',
  ParentAccess_Status.updateError: 'updateError',
};
