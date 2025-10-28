import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../shared/models/reward.dart';
import '../../../shared/models/reward_redemption.dart';

part 'state.g.dart';

enum ParentRewards_LoadStatus { initial, loading, loaded, error }
enum ParentRewards_CreateStatus { initial, creating, success, error }
enum ParentRewards_UpdateStatus { initial, updating, success, error }
enum ParentRewards_DeleteStatus { initial, deleting, success, error }
enum ParentRewards_RedemptionLoadStatus { initial, loading, loaded, error }

@JsonSerializable()
class ParentRewards_State extends Equatable {
  const ParentRewards_State({
    required this.loadStatus,
    required this.createStatus,
    required this.updateStatus,
    required this.deleteStatus,
    required this.redemptionLoadStatus,
    required this.rewards,
    required this.redemptions,
    this.loadErrorMessage,
    this.createErrorMessage,
    this.updateErrorMessage,
    this.deleteErrorMessage,
    this.redemptionLoadErrorMessage,
  });

  factory ParentRewards_State.fromJson(Map<String, dynamic> json) =>
      _$ParentRewards_StateFromJson(json);

  final ParentRewards_LoadStatus loadStatus;
  final ParentRewards_CreateStatus createStatus;
  final ParentRewards_UpdateStatus updateStatus;
  final ParentRewards_DeleteStatus deleteStatus;
  final ParentRewards_RedemptionLoadStatus redemptionLoadStatus;
  final List<Reward> rewards;
  final List<RewardRedemption> redemptions;
  final String? loadErrorMessage;
  final String? createErrorMessage;
  final String? updateErrorMessage;
  final String? deleteErrorMessage;
  final String? redemptionLoadErrorMessage;

  ParentRewards_State copyWith({
    ParentRewards_LoadStatus? loadStatus,
    ParentRewards_CreateStatus? createStatus,
    ParentRewards_UpdateStatus? updateStatus,
    ParentRewards_DeleteStatus? deleteStatus,
    ParentRewards_RedemptionLoadStatus? redemptionLoadStatus,
    List<Reward>? rewards,
    List<RewardRedemption>? redemptions,
    String? Function()? setLoadErrorMessage,
    String? Function()? setCreateErrorMessage,
    String? Function()? setUpdateErrorMessage,
    String? Function()? setDeleteErrorMessage,
    String? Function()? setRedemptionLoadErrorMessage,
  }) {
    return ParentRewards_State(
      loadStatus: loadStatus ?? this.loadStatus,
      createStatus: createStatus ?? this.createStatus,
      updateStatus: updateStatus ?? this.updateStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      redemptionLoadStatus: redemptionLoadStatus ?? this.redemptionLoadStatus,
      rewards: rewards ?? this.rewards,
      redemptions: redemptions ?? this.redemptions,
      loadErrorMessage:
          setLoadErrorMessage != null ? setLoadErrorMessage() : loadErrorMessage,
      createErrorMessage: setCreateErrorMessage != null
          ? setCreateErrorMessage()
          : createErrorMessage,
      updateErrorMessage: setUpdateErrorMessage != null
          ? setUpdateErrorMessage()
          : updateErrorMessage,
      deleteErrorMessage: setDeleteErrorMessage != null
          ? setDeleteErrorMessage()
          : deleteErrorMessage,
      redemptionLoadErrorMessage: setRedemptionLoadErrorMessage != null
          ? setRedemptionLoadErrorMessage()
          : redemptionLoadErrorMessage,
    );
  }

  factory ParentRewards_State.initial() {
    return const ParentRewards_State(
      loadStatus: ParentRewards_LoadStatus.initial,
      createStatus: ParentRewards_CreateStatus.initial,
      updateStatus: ParentRewards_UpdateStatus.initial,
      deleteStatus: ParentRewards_DeleteStatus.initial,
      redemptionLoadStatus: ParentRewards_RedemptionLoadStatus.initial,
      rewards: [],
      redemptions: [],
    );
  }

  @override
  List<Object?> get props => [
    loadStatus,
    createStatus,
    updateStatus,
    deleteStatus,
    redemptionLoadStatus,
    rewards,
    redemptions,
    loadErrorMessage,
    createErrorMessage,
    updateErrorMessage,
    deleteErrorMessage,
    redemptionLoadErrorMessage,
  ];

  Map<String, dynamic> toJson() => _$ParentRewards_StateToJson(this);
}
