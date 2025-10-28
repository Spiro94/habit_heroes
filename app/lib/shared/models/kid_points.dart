import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'kid_points.g.dart';

/// Represents kid points and stats
/// Maps to get_kids_points() function result
@JsonSerializable(fieldRename: FieldRename.snake)
class KidPoints extends Equatable {
  const KidPoints({
    required this.kidId,
    required this.kidName,
    required this.totalPoints,
    required this.tasksCompletedToday,
    required this.tasksPendingToday,
    this.kidAvatar,
    this.kidColor,
  });

  final String kidId;
  final String kidName;
  final String? kidAvatar;
  final String? kidColor;
  final int totalPoints;
  final int tasksCompletedToday;
  final int tasksPendingToday;

  factory KidPoints.fromJson(Map<String, dynamic> json) =>
      _$KidPointsFromJson(json);

  Map<String, dynamic> toJson() => _$KidPointsToJson(this);

  @override
  List<Object?> get props => [
        kidId,
        kidName,
        kidAvatar,
        kidColor,
        totalPoints,
        tasksCompletedToday,
        tasksPendingToday,
      ];
}
