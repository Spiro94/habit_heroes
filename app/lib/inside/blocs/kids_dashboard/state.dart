import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../shared/models/kid_points.dart';
import '../../../shared/models/today_task.dart';

part 'state.g.dart';

enum LoadStatus { initial, loading, loaded, error }

enum CompleteTaskStatus { initial, completing, success, error }

enum SkipTaskStatus { initial, skipping, success, error }

@JsonSerializable()
class KidsDashboard_State extends Equatable {
  const KidsDashboard_State({
    required this.loadStatus,
    required this.completeTaskStatus,
    required this.skipTaskStatus,
    required this.todayTasks,
    required this.kidsPoints,
    this.loadErrorMessage,
    this.completeTaskErrorMessage,
    this.skipTaskErrorMessage,
  });

  factory KidsDashboard_State.initial() => const KidsDashboard_State(
        loadStatus: LoadStatus.initial,
        completeTaskStatus: CompleteTaskStatus.initial,
        skipTaskStatus: SkipTaskStatus.initial,
        todayTasks: [],
        kidsPoints: [],
      );

  final LoadStatus loadStatus;
  final CompleteTaskStatus completeTaskStatus;
  final SkipTaskStatus skipTaskStatus;
  final List<TodayTask> todayTasks;
  final List<KidPoints> kidsPoints;
  final String? loadErrorMessage;
  final String? completeTaskErrorMessage;
  final String? skipTaskErrorMessage;

  KidsDashboard_State copyWith({
    LoadStatus? loadStatus,
    CompleteTaskStatus? completeTaskStatus,
    SkipTaskStatus? skipTaskStatus,
    List<TodayTask>? todayTasks,
    List<KidPoints>? kidsPoints,
    String? Function()? setLoadErrorMessage,
    String? Function()? setCompleteTaskErrorMessage,
    String? Function()? setSkipTaskErrorMessage,
  }) {
    return KidsDashboard_State(
      loadStatus: loadStatus ?? this.loadStatus,
      completeTaskStatus: completeTaskStatus ?? this.completeTaskStatus,
      skipTaskStatus: skipTaskStatus ?? this.skipTaskStatus,
      todayTasks: todayTasks ?? this.todayTasks,
      kidsPoints: kidsPoints ?? this.kidsPoints,
      loadErrorMessage: setLoadErrorMessage != null
          ? setLoadErrorMessage()
          : loadErrorMessage,
      completeTaskErrorMessage: setCompleteTaskErrorMessage != null
          ? setCompleteTaskErrorMessage()
          : completeTaskErrorMessage,
      skipTaskErrorMessage: setSkipTaskErrorMessage != null
          ? setSkipTaskErrorMessage()
          : skipTaskErrorMessage,
    );
  }

  factory KidsDashboard_State.fromJson(Map<String, dynamic> json) =>
      _$KidsDashboard_StateFromJson(json);

  Map<String, dynamic> toJson() => _$KidsDashboard_StateToJson(this);

  @override
  List<Object?> get props => [
        loadStatus,
        completeTaskStatus,
        skipTaskStatus,
        todayTasks,
        kidsPoints,
        loadErrorMessage,
        completeTaskErrorMessage,
        skipTaskErrorMessage,
      ];
}
