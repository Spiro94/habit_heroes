import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../shared/models/kid_points.dart';
import '../../../shared/models/reward.dart';
import '../../../shared/models/today_task.dart';

part 'state.g.dart';

enum LoadStatus { initial, loading, loaded, error }

enum CompleteTaskStatus { initial, completing, success, error }

enum SkipTaskStatus { initial, skipping, success, error }

enum RedeemRewardStatus { initial, redeeming, success, error }

@JsonSerializable()
class KidsDashboard_State extends Equatable {
  const KidsDashboard_State({
    required this.loadStatus,
    required this.completeTaskStatus,
    required this.skipTaskStatus,
    required this.redeemRewardStatus,
    required this.todayTasks,
    required this.kidsPoints,
    required this.rewards,
    this.loadErrorMessage,
    this.completeTaskErrorMessage,
    this.skipTaskErrorMessage,
    this.redeemRewardErrorMessage,
  });

  factory KidsDashboard_State.initial() => const KidsDashboard_State(
        loadStatus: LoadStatus.initial,
        completeTaskStatus: CompleteTaskStatus.initial,
        skipTaskStatus: SkipTaskStatus.initial,
        redeemRewardStatus: RedeemRewardStatus.initial,
        todayTasks: [],
        kidsPoints: [],
        rewards: [],
      );

  final LoadStatus loadStatus;
  final CompleteTaskStatus completeTaskStatus;
  final SkipTaskStatus skipTaskStatus;
  final RedeemRewardStatus redeemRewardStatus;
  final List<TodayTask> todayTasks;
  final List<KidPoints> kidsPoints;
  final List<Reward> rewards;
  final String? loadErrorMessage;
  final String? completeTaskErrorMessage;
  final String? skipTaskErrorMessage;
  final String? redeemRewardErrorMessage;

  KidsDashboard_State copyWith({
    LoadStatus? loadStatus,
    CompleteTaskStatus? completeTaskStatus,
    SkipTaskStatus? skipTaskStatus,
    RedeemRewardStatus? redeemRewardStatus,
    List<TodayTask>? todayTasks,
    List<KidPoints>? kidsPoints,
    List<Reward>? rewards,
    String? Function()? setLoadErrorMessage,
    String? Function()? setCompleteTaskErrorMessage,
    String? Function()? setSkipTaskErrorMessage,
    String? Function()? setRedeemRewardErrorMessage,
  }) {
    return KidsDashboard_State(
      loadStatus: loadStatus ?? this.loadStatus,
      completeTaskStatus: completeTaskStatus ?? this.completeTaskStatus,
      skipTaskStatus: skipTaskStatus ?? this.skipTaskStatus,
      redeemRewardStatus: redeemRewardStatus ?? this.redeemRewardStatus,
      todayTasks: todayTasks ?? this.todayTasks,
      kidsPoints: kidsPoints ?? this.kidsPoints,
      rewards: rewards ?? this.rewards,
      loadErrorMessage: setLoadErrorMessage != null
          ? setLoadErrorMessage()
          : loadErrorMessage,
      completeTaskErrorMessage: setCompleteTaskErrorMessage != null
          ? setCompleteTaskErrorMessage()
          : completeTaskErrorMessage,
      skipTaskErrorMessage: setSkipTaskErrorMessage != null
          ? setSkipTaskErrorMessage()
          : skipTaskErrorMessage,
      redeemRewardErrorMessage: setRedeemRewardErrorMessage != null
          ? setRedeemRewardErrorMessage()
          : redeemRewardErrorMessage,
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
        redeemRewardStatus,
        todayTasks,
        kidsPoints,
        rewards,
        loadErrorMessage,
        completeTaskErrorMessage,
        skipTaskErrorMessage,
        redeemRewardErrorMessage,
      ];
}
