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
      todayTasks: (json['todayTasks'] as List<dynamic>)
          .map((e) => TodayTask.fromJson(e as Map<String, dynamic>))
          .toList(),
      kidsPoints: (json['kidsPoints'] as List<dynamic>)
          .map((e) => KidPoints.fromJson(e as Map<String, dynamic>))
          .toList(),
      loadErrorMessage: json['loadErrorMessage'] as String?,
      completeTaskErrorMessage: json['completeTaskErrorMessage'] as String?,
      skipTaskErrorMessage: json['skipTaskErrorMessage'] as String?,
    );

Map<String, dynamic> _$KidsDashboard_StateToJson(
  KidsDashboard_State instance,
) => <String, dynamic>{
  'loadStatus': _$LoadStatusEnumMap[instance.loadStatus]!,
  'completeTaskStatus':
      _$CompleteTaskStatusEnumMap[instance.completeTaskStatus]!,
  'skipTaskStatus': _$SkipTaskStatusEnumMap[instance.skipTaskStatus]!,
  'todayTasks': instance.todayTasks,
  'kidsPoints': instance.kidsPoints,
  'loadErrorMessage': instance.loadErrorMessage,
  'completeTaskErrorMessage': instance.completeTaskErrorMessage,
  'skipTaskErrorMessage': instance.skipTaskErrorMessage,
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
