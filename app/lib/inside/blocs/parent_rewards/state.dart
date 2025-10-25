import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

enum ParentRewards_Status { initial, loading, loaded, error }

@JsonSerializable()
class ParentRewards_State extends Equatable {
  const ParentRewards_State({
    required this.status,
    this.rewards,
    this.errorMessage,
  });

  factory ParentRewards_State.fromJson(Map<String, dynamic> json) =>
      _$ParentRewards_StateFromJson(json);

  final ParentRewards_Status status;
  final List<String>? rewards; // Placeholder for now
  final String? errorMessage;

  ParentRewards_State copyWith({
    ParentRewards_Status? status,
    List<String>? rewards,
    String? Function()? setErrorMessage,
  }) {
    return ParentRewards_State(
      status: status ?? this.status,
      rewards: rewards ?? this.rewards,
      errorMessage: setErrorMessage != null ? setErrorMessage() : errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, rewards, errorMessage];

  Map<String, dynamic> toJson() => _$ParentRewards_StateToJson(this);
}
