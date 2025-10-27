import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../shared/models/kid.dart';
import '../../../shared/models/task_instance.dart';
import '../../../shared/models/task_schedule.dart';
import '../../../shared/models/task_template.dart';

part 'state.g.dart';

enum LoadStatus { initial, loading, loaded, error }

enum CreateTaskStatus { initial, creating, success, error }

enum UpdateTaskStatus { initial, updating, success, error }

enum DeleteTaskStatus { initial, deleting, success, error }

enum LoadEditingDataStatus { initial, loading, loaded, error }

@JsonSerializable()
class ParentTasks_State extends Equatable {
  const ParentTasks_State({
    required this.loadStatus,
    required this.createTaskStatus,
    required this.updateTaskStatus,
    required this.deleteTaskStatus,
    required this.loadEditingDataStatus,
    required this.taskInstances,
    required this.kids,
    required this.taskTemplates,
    required this.taskSchedules,
    required this.editingSchedules,
    this.loadErrorMessage,
    this.createTaskErrorMessage,
    this.updateTaskErrorMessage,
    this.deleteTaskErrorMessage,
    this.loadEditingDataErrorMessage,
    this.editingTemplate,
  });

  final LoadStatus loadStatus;
  final CreateTaskStatus createTaskStatus;
  final UpdateTaskStatus updateTaskStatus;
  final DeleteTaskStatus deleteTaskStatus;
  final LoadEditingDataStatus loadEditingDataStatus;
  final List<TaskInstance> taskInstances;
  final List<Kid> kids;
  final List<TaskTemplate> taskTemplates;
  final List<TaskSchedule> taskSchedules;
  final String? loadErrorMessage;
  final String? createTaskErrorMessage;
  final String? updateTaskErrorMessage;
  final String? deleteTaskErrorMessage;
  final String? loadEditingDataErrorMessage;
  final List<TaskSchedule> editingSchedules;
  final TaskTemplate? editingTemplate;

  ParentTasks_State copyWith({
    LoadStatus? loadStatus,
    CreateTaskStatus? createTaskStatus,
    UpdateTaskStatus? updateTaskStatus,
    DeleteTaskStatus? deleteTaskStatus,
    LoadEditingDataStatus? loadEditingDataStatus,
    List<TaskInstance>? taskInstances,
    List<Kid>? kids,
    List<TaskTemplate>? taskTemplates,
    List<TaskSchedule>? taskSchedules,
    String? Function()? setLoadErrorMessage,
    String? Function()? setCreateTaskErrorMessage,
    String? Function()? setUpdateTaskErrorMessage,
    String? Function()? setDeleteTaskErrorMessage,
    String? Function()? setLoadEditingDataErrorMessage,
    List<TaskSchedule>? Function()? setEditingSchedules,
    TaskTemplate? Function()? setEditingTemplate,
  }) {
    return ParentTasks_State(
      loadStatus: loadStatus ?? this.loadStatus,
      createTaskStatus: createTaskStatus ?? this.createTaskStatus,
      updateTaskStatus: updateTaskStatus ?? this.updateTaskStatus,
      deleteTaskStatus: deleteTaskStatus ?? this.deleteTaskStatus,
      loadEditingDataStatus:
          loadEditingDataStatus ?? this.loadEditingDataStatus,
      taskInstances: taskInstances ?? this.taskInstances,
      kids: kids ?? this.kids,
      taskTemplates: taskTemplates ?? this.taskTemplates,
      taskSchedules: taskSchedules ?? this.taskSchedules,
      loadErrorMessage: setLoadErrorMessage != null
          ? setLoadErrorMessage()
          : loadErrorMessage,
      createTaskErrorMessage: setCreateTaskErrorMessage != null
          ? setCreateTaskErrorMessage()
          : createTaskErrorMessage,
      updateTaskErrorMessage: setUpdateTaskErrorMessage != null
          ? setUpdateTaskErrorMessage()
          : updateTaskErrorMessage,
      deleteTaskErrorMessage: setDeleteTaskErrorMessage != null
          ? setDeleteTaskErrorMessage()
          : deleteTaskErrorMessage,
      loadEditingDataErrorMessage: setLoadEditingDataErrorMessage != null
          ? setLoadEditingDataErrorMessage()
          : loadEditingDataErrorMessage,
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
      loadStatus: LoadStatus.initial,
      createTaskStatus: CreateTaskStatus.initial,
      updateTaskStatus: UpdateTaskStatus.initial,
      deleteTaskStatus: DeleteTaskStatus.initial,
      loadEditingDataStatus: LoadEditingDataStatus.initial,
      taskInstances: [],
      kids: [],
      taskTemplates: [],
      taskSchedules: [],
      editingSchedules: [],
      loadErrorMessage: null,
      createTaskErrorMessage: null,
      updateTaskErrorMessage: null,
      deleteTaskErrorMessage: null,
      loadEditingDataErrorMessage: null,
      editingTemplate: null,
    );
  }

  @override
  List<Object?> get props => [
    loadStatus,
    createTaskStatus,
    updateTaskStatus,
    deleteTaskStatus,
    loadEditingDataStatus,
    taskInstances,
    kids,
    taskTemplates,
    taskSchedules,
    loadErrorMessage,
    createTaskErrorMessage,
    updateTaskErrorMessage,
    deleteTaskErrorMessage,
    loadEditingDataErrorMessage,
    editingSchedules,
    editingTemplate,
  ];

  Map<String, dynamic> toJson() => _$ParentTasks_StateToJson(this);
  factory ParentTasks_State.fromJson(Map<String, dynamic> json) =>
      _$ParentTasks_StateFromJson(json);
}
