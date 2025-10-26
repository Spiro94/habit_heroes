// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParentTasks_State _$ParentTasks_StateFromJson(Map<String, dynamic> json) =>
    ParentTasks_State(
      status: $enumDecode(_$ParentTasks_StatusEnumMap, json['status']),
      tasks: (json['tasks'] as List<dynamic>)
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
      kids: (json['kids'] as List<dynamic>)
          .map((e) => AppUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$ParentTasks_StateToJson(ParentTasks_State instance) =>
    <String, dynamic>{
      'status': _$ParentTasks_StatusEnumMap[instance.status]!,
      'tasks': instance.tasks,
      'kids': instance.kids,
      'errorMessage': instance.errorMessage,
    };

const _$ParentTasks_StatusEnumMap = {
  ParentTasks_Status.initial: 'initial',
  ParentTasks_Status.loading: 'loading',
  ParentTasks_Status.loaded: 'loaded',
  ParentTasks_Status.error: 'error',
};
