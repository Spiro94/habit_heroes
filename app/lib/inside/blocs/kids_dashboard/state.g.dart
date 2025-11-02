// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KidsDashboard_State _$KidsDashboard_StateFromJson(Map<String, dynamic> json) =>
    KidsDashboard_State(
      status: $enumDecode(_$KidsDashboard_StatusEnumMap, json['status']),
      todayTasks: (json['todayTasks'] as List<dynamic>)
          .map((e) => TodayTask.fromJson(e as Map<String, dynamic>))
          .toList(),
      kidsPoints: (json['kidsPoints'] as List<dynamic>)
          .map((e) => KidPoints.fromJson(e as Map<String, dynamic>))
          .toList(),
      rewards: (json['rewards'] as List<dynamic>)
          .map((e) => Reward.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$KidsDashboard_StateToJson(
  KidsDashboard_State instance,
) => <String, dynamic>{
  'status': _$KidsDashboard_StatusEnumMap[instance.status]!,
  'todayTasks': instance.todayTasks,
  'kidsPoints': instance.kidsPoints,
  'rewards': instance.rewards,
  'errorMessage': instance.errorMessage,
};

const _$KidsDashboard_StatusEnumMap = {
  KidsDashboard_Status.initial: 'initial',
  KidsDashboard_Status.loading: 'loading',
  KidsDashboard_Status.loaded: 'loaded',
  KidsDashboard_Status.loadError: 'loadError',
  KidsDashboard_Status.completing: 'completing',
  KidsDashboard_Status.completeSuccess: 'completeSuccess',
  KidsDashboard_Status.completeError: 'completeError',
  KidsDashboard_Status.uncompleting: 'uncompleting',
  KidsDashboard_Status.uncompleteSuccess: 'uncompleteSuccess',
  KidsDashboard_Status.uncompleteError: 'uncompleteError',
  KidsDashboard_Status.skipping: 'skipping',
  KidsDashboard_Status.skipSuccess: 'skipSuccess',
  KidsDashboard_Status.skipError: 'skipError',
  KidsDashboard_Status.redeeming: 'redeeming',
  KidsDashboard_Status.redeemSuccess: 'redeemSuccess',
  KidsDashboard_Status.redeemError: 'redeemError',
};
