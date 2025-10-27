// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParentTasks_State _$ParentTasks_StateFromJson(
  Map<String, dynamic> json,
) => ParentTasks_State(
  loadStatus: $enumDecode(_$LoadStatusEnumMap, json['loadStatus']),
  createTaskStatus: $enumDecode(
    _$CreateTaskStatusEnumMap,
    json['createTaskStatus'],
  ),
  updateTaskStatus: $enumDecode(
    _$UpdateTaskStatusEnumMap,
    json['updateTaskStatus'],
  ),
  deleteTaskStatus: $enumDecode(
    _$DeleteTaskStatusEnumMap,
    json['deleteTaskStatus'],
  ),
  loadEditingDataStatus: $enumDecode(
    _$LoadEditingDataStatusEnumMap,
    json['loadEditingDataStatus'],
  ),
  taskInstances: (json['taskInstances'] as List<dynamic>)
      .map((e) => TaskInstance.fromJson(e as Map<String, dynamic>))
      .toList(),
  kids: (json['kids'] as List<dynamic>)
      .map((e) => Kid.fromJson(e as Map<String, dynamic>))
      .toList(),
  taskTemplates: (json['taskTemplates'] as List<dynamic>)
      .map((e) => TaskTemplate.fromJson(e as Map<String, dynamic>))
      .toList(),
  taskSchedules: (json['taskSchedules'] as List<dynamic>)
      .map((e) => TaskSchedule.fromJson(e as Map<String, dynamic>))
      .toList(),
  editingSchedules: (json['editingSchedules'] as List<dynamic>)
      .map((e) => TaskSchedule.fromJson(e as Map<String, dynamic>))
      .toList(),
  loadErrorMessage: json['loadErrorMessage'] as String?,
  createTaskErrorMessage: json['createTaskErrorMessage'] as String?,
  updateTaskErrorMessage: json['updateTaskErrorMessage'] as String?,
  deleteTaskErrorMessage: json['deleteTaskErrorMessage'] as String?,
  loadEditingDataErrorMessage: json['loadEditingDataErrorMessage'] as String?,
  editingTemplate: json['editingTemplate'] == null
      ? null
      : TaskTemplate.fromJson(json['editingTemplate'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ParentTasks_StateToJson(ParentTasks_State instance) =>
    <String, dynamic>{
      'loadStatus': _$LoadStatusEnumMap[instance.loadStatus]!,
      'createTaskStatus': _$CreateTaskStatusEnumMap[instance.createTaskStatus]!,
      'updateTaskStatus': _$UpdateTaskStatusEnumMap[instance.updateTaskStatus]!,
      'deleteTaskStatus': _$DeleteTaskStatusEnumMap[instance.deleteTaskStatus]!,
      'loadEditingDataStatus':
          _$LoadEditingDataStatusEnumMap[instance.loadEditingDataStatus]!,
      'taskInstances': instance.taskInstances,
      'kids': instance.kids,
      'taskTemplates': instance.taskTemplates,
      'taskSchedules': instance.taskSchedules,
      'loadErrorMessage': instance.loadErrorMessage,
      'createTaskErrorMessage': instance.createTaskErrorMessage,
      'updateTaskErrorMessage': instance.updateTaskErrorMessage,
      'deleteTaskErrorMessage': instance.deleteTaskErrorMessage,
      'loadEditingDataErrorMessage': instance.loadEditingDataErrorMessage,
      'editingSchedules': instance.editingSchedules,
      'editingTemplate': instance.editingTemplate,
    };

const _$LoadStatusEnumMap = {
  LoadStatus.initial: 'initial',
  LoadStatus.loading: 'loading',
  LoadStatus.loaded: 'loaded',
  LoadStatus.error: 'error',
};

const _$CreateTaskStatusEnumMap = {
  CreateTaskStatus.initial: 'initial',
  CreateTaskStatus.creating: 'creating',
  CreateTaskStatus.success: 'success',
  CreateTaskStatus.error: 'error',
};

const _$UpdateTaskStatusEnumMap = {
  UpdateTaskStatus.initial: 'initial',
  UpdateTaskStatus.updating: 'updating',
  UpdateTaskStatus.success: 'success',
  UpdateTaskStatus.error: 'error',
};

const _$DeleteTaskStatusEnumMap = {
  DeleteTaskStatus.initial: 'initial',
  DeleteTaskStatus.deleting: 'deleting',
  DeleteTaskStatus.success: 'success',
  DeleteTaskStatus.error: 'error',
};

const _$LoadEditingDataStatusEnumMap = {
  LoadEditingDataStatus.initial: 'initial',
  LoadEditingDataStatus.loading: 'loading',
  LoadEditingDataStatus.loaded: 'loaded',
  LoadEditingDataStatus.error: 'error',
};
