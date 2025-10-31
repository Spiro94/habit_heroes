import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../shared/models/kid.dart';
import '../../../shared/models/task_instance.dart';
import '../../../shared/models/task_schedule.dart';
import '../../../shared/models/task_template.dart';

part 'state.g.dart';

// Single status enum with descriptive values for all actions
enum ParentTasks_Status {
  initial,
  loading,
  loaded,
  loadError,
  creating,
  createSuccess,
  createError,
  updating,
  updateSuccess,
  updateError,
  deleting,
  deleteSuccess,
  deleteError,
  loadingEditingData,
  loadedEditingData,
  loadEditingDataError,
}

@JsonSerializable()
class ParentTasks_State extends Equatable {
  const ParentTasks_State({
    required this.status,
    required this.taskInstances,
    required this.kids,
    required this.taskTemplates,
    required this.taskSchedules,
    required this.editingSchedules,
    this.errorMessage,
    this.editingTemplate,
  });

  final ParentTasks_Status status;
  final List<TaskInstance> taskInstances;
  final List<Kid> kids;
  final List<TaskTemplate> taskTemplates;
  final List<TaskSchedule> taskSchedules;
  final String? errorMessage;
  final List<TaskSchedule> editingSchedules;
  final TaskTemplate? editingTemplate;

  ParentTasks_State copyWith({
    ParentTasks_Status? status,
    List<TaskInstance>? taskInstances,
    List<Kid>? kids,
    List<TaskTemplate>? taskTemplates,
    List<TaskSchedule>? taskSchedules,
    String? Function()? setErrorMessage,
    List<TaskSchedule>? Function()? setEditingSchedules,
    TaskTemplate? Function()? setEditingTemplate,
  }) {
    return ParentTasks_State(
      status: status ?? this.status,
      taskInstances: taskInstances ?? this.taskInstances,
      kids: kids ?? this.kids,
      taskTemplates: taskTemplates ?? this.taskTemplates,
      taskSchedules: taskSchedules ?? this.taskSchedules,
      errorMessage: setErrorMessage != null
          ? setErrorMessage()
          : errorMessage,
      editingSchedules: setEditingSchedules != null
          ? setEditingSchedules()!
          : editingSchedules,
      editingTemplate: setEditingTemplate != null
          ? setEditingTemplate()
          : editingTemplate,
    );
  }

  factory ParentTasks_State.initial() {
    return const ParentTasks_State(
      status: ParentTasks_Status.initial,
      taskInstances: [],
      kids: [],
      taskTemplates: [],
      taskSchedules: [],
      editingSchedules: [],
      errorMessage: null,
      editingTemplate: null,
    );
  }

  @override
  List<Object?> get props => [
    status,
    taskInstances,
    kids,
    taskTemplates,
    taskSchedules,
    errorMessage,
    editingSchedules,
    editingTemplate,
  ];

  Map<String, dynamic> toJson() => _$ParentTasks_StateToJson(this);
  factory ParentTasks_State.fromJson(Map<String, dynamic> json) =>
      _$ParentTasks_StateFromJson(json);
}
