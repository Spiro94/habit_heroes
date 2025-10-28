// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KidsDashboard_State _$KidsDashboard_StateFromJson(Map<String, dynamic> json) =>
    KidsDashboard_State(
      loadStatus: $enumDecode(_$LoadStatusEnumMap, json['loadStatus']),
      completeTaskStatus: $enumDecode(
        _$CompleteTaskStatusEnumMap,
        json['completeTaskStatus'],
      ),
      skipTaskStatus: $enumDecode(
        _$SkipTaskStatusEnumMap,
        json['skipTaskStatus'],
      ),
      redeemRewardStatus: $enumDecode(
        _$RedeemRewardStatusEnumMap,
        json['redeemRewardStatus'],
      ),
      todayTasks: (json['todayTasks'] as List<dynamic>)
          .map((e) => TodayTask.fromJson(e as Map<String, dynamic>))
          .toList(),
      kidsPoints: (json['kidsPoints'] as List<dynamic>)
          .map((e) => KidPoints.fromJson(e as Map<String, dynamic>))
          .toList(),
      rewards: (json['rewards'] as List<dynamic>)
          .map((e) => Reward.fromJson(e as Map<String, dynamic>))
          .toList(),
      loadErrorMessage: json['loadErrorMessage'] as String?,
      completeTaskErrorMessage: json['completeTaskErrorMessage'] as String?,
      skipTaskErrorMessage: json['skipTaskErrorMessage'] as String?,
      redeemRewardErrorMessage: json['redeemRewardErrorMessage'] as String?,
    );

Map<String, dynamic> _$KidsDashboard_StateToJson(
  KidsDashboard_State instance,
) => <String, dynamic>{
  'loadStatus': _$LoadStatusEnumMap[instance.loadStatus]!,
  'completeTaskStatus':
      _$CompleteTaskStatusEnumMap[instance.completeTaskStatus]!,
  'skipTaskStatus': _$SkipTaskStatusEnumMap[instance.skipTaskStatus]!,
  'redeemRewardStatus':
      _$RedeemRewardStatusEnumMap[instance.redeemRewardStatus]!,
  'todayTasks': instance.todayTasks,
  'kidsPoints': instance.kidsPoints,
  'rewards': instance.rewards,
  'loadErrorMessage': instance.loadErrorMessage,
  'completeTaskErrorMessage': instance.completeTaskErrorMessage,
  'skipTaskErrorMessage': instance.skipTaskErrorMessage,
  'redeemRewardErrorMessage': instance.redeemRewardErrorMessage,
};

const _$LoadStatusEnumMap = {
  LoadStatus.initial: 'initial',
  LoadStatus.loading: 'loading',
  LoadStatus.loaded: 'loaded',
  LoadStatus.error: 'error',
};

const _$CompleteTaskStatusEnumMap = {
  CompleteTaskStatus.initial: 'initial',
  CompleteTaskStatus.completing: 'completing',
  CompleteTaskStatus.success: 'success',
  CompleteTaskStatus.error: 'error',
};

const _$SkipTaskStatusEnumMap = {
  SkipTaskStatus.initial: 'initial',
  SkipTaskStatus.skipping: 'skipping',
  SkipTaskStatus.success: 'success',
  SkipTaskStatus.error: 'error',
};

const _$RedeemRewardStatusEnumMap = {
  RedeemRewardStatus.initial: 'initial',
  RedeemRewardStatus.redeeming: 'redeeming',
  RedeemRewardStatus.success: 'success',
  RedeemRewardStatus.error: 'error',
};
