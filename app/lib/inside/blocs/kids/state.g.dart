// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kids_State _$Kids_StateFromJson(Map<String, dynamic> json) => Kids_State(
  status: $enumDecode(_$Kids_StatusEnumMap, json['status']),
  kids: (json['kids'] as List<dynamic>)
      .map((e) => Kid.fromJson(e as Map<String, dynamic>))
      .toList(),
  errorMessage: json['errorMessage'] as String?,
);

Map<String, dynamic> _$Kids_StateToJson(Kids_State instance) =>
    <String, dynamic>{
      'status': _$Kids_StatusEnumMap[instance.status]!,
      'kids': instance.kids,
      'errorMessage': instance.errorMessage,
    };

const _$Kids_StatusEnumMap = {
  Kids_Status.initial: 'initial',
  Kids_Status.loading: 'loading',
  Kids_Status.loaded: 'loaded',
  Kids_Status.error: 'error',
};
