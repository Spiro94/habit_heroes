import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'family.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Family extends Equatable {
  const Family({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.familyCode,
  });

  factory Family.fromJson(Map<String, dynamic> json) => _$FamilyFromJson(json);

  final String id;
  final DateTime createdAt;
  final String name;
  final String familyCode;

  Map<String, dynamic> toJson() => _$FamilyToJson(this);

  @override
  List<Object?> get props => [id, createdAt, name, familyCode];
}
