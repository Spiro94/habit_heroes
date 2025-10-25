// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParentRewards_State _$ParentRewards_StateFromJson(Map<String, dynamic> json) =>
    ParentRewards_State(
      status: $enumDecode(_$ParentRewards_StatusEnumMap, json['status']),
      rewards: (json['rewards'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$ParentRewards_StateToJson(
  ParentRewards_State instance,
) => <String, dynamic>{
  'status': _$ParentRewards_StatusEnumMap[instance.status]!,
  'rewards': instance.rewards,
  'errorMessage': instance.errorMessage,
};

const _$ParentRewards_StatusEnumMap = {
  ParentRewards_Status.initial: 'initial',
  ParentRewards_Status.loading: 'loading',
  ParentRewards_Status.loaded: 'loaded',
  ParentRewards_Status.error: 'error',
};
