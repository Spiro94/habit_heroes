// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTask_State _$CreateTask_StateFromJson(Map<String, dynamic> json) =>
    CreateTask_State(
      status:
          $enumDecodeNullable(_$CreateTask_StatusEnumMap, json['status']) ??
          CreateTask_Status.initial,
      kids:
          (json['kids'] as List<dynamic>?)
              ?.map((e) => AppUser.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      title: json['title'] as String?,
      assigneeId: json['assigneeId'] as String?,
      points: (json['points'] as num?)?.toInt(),
      isRepetitive: json['isRepetitive'] as bool? ?? false,
      daysOfWeek:
          (json['daysOfWeek'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      partsOfDay:
          (json['partsOfDay'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$CreateTask_StateToJson(CreateTask_State instance) =>
    <String, dynamic>{
      'status': _$CreateTask_StatusEnumMap[instance.status]!,
      'kids': instance.kids,
      'title': instance.title,
      'assigneeId': instance.assigneeId,
      'points': instance.points,
      'isRepetitive': instance.isRepetitive,
      'daysOfWeek': instance.daysOfWeek,
      'partsOfDay': instance.partsOfDay,
      'errorMessage': instance.errorMessage,
    };

const _$CreateTask_StatusEnumMap = {
  CreateTask_Status.initial: 'initial',
  CreateTask_Status.loading: 'loading',
  CreateTask_Status.loaded: 'loaded',
  CreateTask_Status.error: 'error',
};
