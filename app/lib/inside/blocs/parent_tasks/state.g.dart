// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParentTasks_State _$ParentTasks_StateFromJson(Map<String, dynamic> json) =>
    ParentTasks_State(
      status: $enumDecode(_$ParentTasks_StatusEnumMap, json['status']),
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
      errorMessage: json['errorMessage'] as String?,
      editingTemplate: json['editingTemplate'] == null
          ? null
          : TaskTemplate.fromJson(
              json['editingTemplate'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ParentTasks_StateToJson(ParentTasks_State instance) =>
    <String, dynamic>{
      'status': _$ParentTasks_StatusEnumMap[instance.status]!,
      'taskInstances': instance.taskInstances,
      'kids': instance.kids,
      'taskTemplates': instance.taskTemplates,
      'taskSchedules': instance.taskSchedules,
      'errorMessage': instance.errorMessage,
      'editingSchedules': instance.editingSchedules,
      'editingTemplate': instance.editingTemplate,
    };

const _$ParentTasks_StatusEnumMap = {
  ParentTasks_Status.initial: 'initial',
  ParentTasks_Status.loading: 'loading',
  ParentTasks_Status.loaded: 'loaded',
  ParentTasks_Status.loadError: 'loadError',
  ParentTasks_Status.creating: 'creating',
  ParentTasks_Status.createSuccess: 'createSuccess',
  ParentTasks_Status.createError: 'createError',
  ParentTasks_Status.updating: 'updating',
  ParentTasks_Status.updateSuccess: 'updateSuccess',
  ParentTasks_Status.updateError: 'updateError',
  ParentTasks_Status.deleting: 'deleting',
  ParentTasks_Status.deleteSuccess: 'deleteSuccess',
  ParentTasks_Status.deleteError: 'deleteError',
  ParentTasks_Status.loadingEditingData: 'loadingEditingData',
  ParentTasks_Status.loadedEditingData: 'loadedEditingData',
  ParentTasks_Status.loadEditingDataError: 'loadEditingDataError',
};
