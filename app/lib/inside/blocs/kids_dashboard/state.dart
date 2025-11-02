import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../shared/models/kid_points.dart';
import '../../../shared/models/reward.dart';
import '../../../shared/models/today_task.dart';

part 'state.g.dart';

enum KidsDashboard_Status {
  initial,
  loading,
  loaded,
  loadError,
  completing,
  completeSuccess,
  completeError,
  uncompleting,
  uncompleteSuccess,
  uncompleteError,
  skipping,
  skipSuccess,
  skipError,
  redeeming,
  redeemSuccess,
  redeemError,
}

@JsonSerializable()
class KidsDashboard_State extends Equatable {
  const KidsDashboard_State({
    required this.status,
    required this.todayTasks,
    required this.kidsPoints,
    required this.rewards,
    this.errorMessage,
  });

  factory KidsDashboard_State.initial() => const KidsDashboard_State(
        status: KidsDashboard_Status.initial,
        todayTasks: [],
        kidsPoints: [],
        rewards: [],
      );

  final KidsDashboard_Status status;
  final List<TodayTask> todayTasks;
  final List<KidPoints> kidsPoints;
  final List<Reward> rewards;
  final String? errorMessage;

  KidsDashboard_State copyWith({
    KidsDashboard_Status? status,
    List<TodayTask>? todayTasks,
    List<KidPoints>? kidsPoints,
    List<Reward>? rewards,
    String? Function()? setErrorMessage,
  }) {
    return KidsDashboard_State(
      status: status ?? this.status,
      todayTasks: todayTasks ?? this.todayTasks,
      kidsPoints: kidsPoints ?? this.kidsPoints,
      rewards: rewards ?? this.rewards,
      errorMessage: setErrorMessage != null ? setErrorMessage() : errorMessage,
    );
  }

  factory KidsDashboard_State.fromJson(Map<String, dynamic> json) =>
      _$KidsDashboard_StateFromJson(json);

  Map<String, dynamic> toJson() => _$KidsDashboard_StateToJson(this);

  @override
  List<Object?> get props => [
        status,
        todayTasks,
        kidsPoints,
        rewards,
        errorMessage,
      ];
}
