import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

enum ParentTasks_Status { initial, loading, loaded, error }

@JsonSerializable()
class ParentTasks_State extends Equatable {
  const ParentTasks_State({
    required this.status,
    this.tasks,
    this.errorMessage,
  });

  factory ParentTasks_State.fromJson(Map<String, dynamic> json) =>
      _$ParentTasks_StateFromJson(json);

  final ParentTasks_Status status;
  final List<String>? tasks; // Placeholder for now
  final String? errorMessage;

  ParentTasks_State copyWith({
    ParentTasks_Status? status,
    List<String>? tasks,
    String? Function()? setErrorMessage,
  }) {
    return ParentTasks_State(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      errorMessage: setErrorMessage != null ? setErrorMessage() : errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, tasks, errorMessage];

  Map<String, dynamic> toJson() => _$ParentTasks_StateToJson(this);
}
