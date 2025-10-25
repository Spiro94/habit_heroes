import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

enum UserRole {
  parent('Parent'),
  kid('Kid');

  final String name;
  const UserRole(this.name);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AppUser extends Equatable {
  const AppUser({
    required this.id,
    required this.displayName,
    required this.role,
  });

  final String id;
  final String displayName;
  final UserRole role;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  @override
  List<Object?> get props => [id, displayName, role];
}
