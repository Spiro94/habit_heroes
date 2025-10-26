import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../shared/models/app_user.dart';
import '../../../shared/models/task.dart';

part 'state.g.dart';

enum ParentTasks_Status { initial, loading, loaded, error }

@JsonSerializable()
class ParentTasks_State extends Equatable {
  const ParentTasks_State({
    required this.status,
    required this.tasks,
    required this.kids,
    this.errorMessage,
  });

  final ParentTasks_Status status;
  final List<Task> tasks;
  final List<AppUser> kids;
  final String? errorMessage;

  ParentTasks_State copyWith({
    ParentTasks_Status? status,
    List<Task>? tasks,
    List<AppUser>? kids,
    String? Function()? setErrorMessage,
  }) {
    return ParentTasks_State(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      kids: kids ?? this.kids,
      errorMessage: setErrorMessage != null ? setErrorMessage() : errorMessage,
    );
  }

  factory ParentTasks_State.initial() {
    return const ParentTasks_State(
      status: ParentTasks_Status.initial,
      tasks: [],
      kids: [],
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [status, tasks, kids, errorMessage];

  Map<String, dynamic> toJson() => _$ParentTasks_StateToJson(this);
  factory ParentTasks_State.fromJson(Map<String, dynamic> json) =>
      _$ParentTasks_StateFromJson(json);
}
