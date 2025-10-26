import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../shared/models/app_user.dart';

part 'state.g.dart';

enum CreateTask_Status { initial, loading, loaded, error }

@JsonSerializable()
class CreateTask_State extends Equatable {
  const CreateTask_State({
    this.status = CreateTask_Status.initial,
    this.kids = const [],
    this.title,
    this.assigneeId,
    this.points,
    this.isRepetitive = false,
    this.daysOfWeek = const [],
    this.partsOfDay = const [],
    this.errorMessage,
  });

  final CreateTask_Status status;
  final List<AppUser> kids;
  final String? title;
  final String? assigneeId;
  final int? points;
  final bool isRepetitive;
  final List<int> daysOfWeek;
  final List<String> partsOfDay;
  final String? errorMessage;

  @override
  List<Object?> get props => [
    status,
    kids,
    title,
    assigneeId,
    points,
    isRepetitive,
    daysOfWeek,
    partsOfDay,
    errorMessage,
  ];

  CreateTask_State copyWith({
    CreateTask_Status? status,
    List<AppUser>? kids,
    String? title,
    String? assigneeId,
    int? points,
    bool? isRepetitive,
    List<int>? daysOfWeek,
    List<String>? partsOfDay,
    String? Function()? errorMessage,
  }) {
    return CreateTask_State(
      status: status ?? this.status,
      kids: kids ?? this.kids,
      title: title ?? this.title,
      assigneeId: assigneeId ?? this.assigneeId,
      points: points ?? this.points,
      isRepetitive: isRepetitive ?? this.isRepetitive,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      partsOfDay: partsOfDay ?? this.partsOfDay,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  factory CreateTask_State.fromJson(Map<String, dynamic> json) =>
      _$CreateTask_StateFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTask_StateToJson(this);
}
