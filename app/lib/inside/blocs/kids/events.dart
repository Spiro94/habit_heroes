import 'package:equatable/equatable.dart';

abstract class Kids_Event extends Equatable {
  const Kids_Event();

  @override
  List<Object?> get props => [];
}

class Kids_Event_LoadKids extends Kids_Event {
  const Kids_Event_LoadKids();
}

class Kids_Event_AddKid extends Kids_Event {
  const Kids_Event_AddKid({
    required this.name,
    this.avatarUrl,
    this.color,
  });

  final String name;
  final String? avatarUrl;
  final String? color;

  @override
  List<Object?> get props => [name, avatarUrl, color];
}

class Kids_Event_UpdateKid extends Kids_Event {
  const Kids_Event_UpdateKid({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.color,
  });

  final String id;
  final String name;
  final String? avatarUrl;
  final String? color;

  @override
  List<Object?> get props => [id, name, avatarUrl, color];
}

class Kids_Event_DeleteKid extends Kids_Event {
  const Kids_Event_DeleteKid({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}
