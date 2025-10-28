// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParentRewards_State _$ParentRewards_StateFromJson(Map<String, dynamic> json) =>
    ParentRewards_State(
      loadStatus: $enumDecode(
        _$ParentRewards_LoadStatusEnumMap,
        json['loadStatus'],
      ),
      createStatus: $enumDecode(
        _$ParentRewards_CreateStatusEnumMap,
        json['createStatus'],
      ),
      updateStatus: $enumDecode(
        _$ParentRewards_UpdateStatusEnumMap,
        json['updateStatus'],
      ),
      deleteStatus: $enumDecode(
        _$ParentRewards_DeleteStatusEnumMap,
        json['deleteStatus'],
      ),
      redemptionLoadStatus: $enumDecode(
        _$ParentRewards_RedemptionLoadStatusEnumMap,
        json['redemptionLoadStatus'],
      ),
      rewards: (json['rewards'] as List<dynamic>)
          .map((e) => Reward.fromJson(e as Map<String, dynamic>))
          .toList(),
      redemptions: (json['redemptions'] as List<dynamic>)
          .map((e) => RewardRedemption.fromJson(e as Map<String, dynamic>))
          .toList(),
      loadErrorMessage: json['loadErrorMessage'] as String?,
      createErrorMessage: json['createErrorMessage'] as String?,
      updateErrorMessage: json['updateErrorMessage'] as String?,
      deleteErrorMessage: json['deleteErrorMessage'] as String?,
      redemptionLoadErrorMessage: json['redemptionLoadErrorMessage'] as String?,
    );

Map<String, dynamic> _$ParentRewards_StateToJson(
  ParentRewards_State instance,
) => <String, dynamic>{
  'loadStatus': _$ParentRewards_LoadStatusEnumMap[instance.loadStatus]!,
  'createStatus': _$ParentRewards_CreateStatusEnumMap[instance.createStatus]!,
  'updateStatus': _$ParentRewards_UpdateStatusEnumMap[instance.updateStatus]!,
  'deleteStatus': _$ParentRewards_DeleteStatusEnumMap[instance.deleteStatus]!,
  'redemptionLoadStatus':
      _$ParentRewards_RedemptionLoadStatusEnumMap[instance
          .redemptionLoadStatus]!,
  'rewards': instance.rewards,
  'redemptions': instance.redemptions,
  'loadErrorMessage': instance.loadErrorMessage,
  'createErrorMessage': instance.createErrorMessage,
  'updateErrorMessage': instance.updateErrorMessage,
  'deleteErrorMessage': instance.deleteErrorMessage,
  'redemptionLoadErrorMessage': instance.redemptionLoadErrorMessage,
};

const _$ParentRewards_LoadStatusEnumMap = {
  ParentRewards_LoadStatus.initial: 'initial',
  ParentRewards_LoadStatus.loading: 'loading',
  ParentRewards_LoadStatus.loaded: 'loaded',
  ParentRewards_LoadStatus.error: 'error',
};

const _$ParentRewards_CreateStatusEnumMap = {
  ParentRewards_CreateStatus.initial: 'initial',
  ParentRewards_CreateStatus.creating: 'creating',
  ParentRewards_CreateStatus.success: 'success',
  ParentRewards_CreateStatus.error: 'error',
};

const _$ParentRewards_UpdateStatusEnumMap = {
  ParentRewards_UpdateStatus.initial: 'initial',
  ParentRewards_UpdateStatus.updating: 'updating',
  ParentRewards_UpdateStatus.success: 'success',
  ParentRewards_UpdateStatus.error: 'error',
};

const _$ParentRewards_DeleteStatusEnumMap = {
  ParentRewards_DeleteStatus.initial: 'initial',
  ParentRewards_DeleteStatus.deleting: 'deleting',
  ParentRewards_DeleteStatus.success: 'success',
  ParentRewards_DeleteStatus.error: 'error',
};

const _$ParentRewards_RedemptionLoadStatusEnumMap = {
  ParentRewards_RedemptionLoadStatus.initial: 'initial',
  ParentRewards_RedemptionLoadStatus.loading: 'loading',
  ParentRewards_RedemptionLoadStatus.loaded: 'loaded',
  ParentRewards_RedemptionLoadStatus.error: 'error',
};
