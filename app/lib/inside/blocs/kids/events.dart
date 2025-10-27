import 'package:equatable/equatable.dart';
import '../../../shared/models/kid.dart';

abstract class Kids_Event extends Equatable {
  const Kids_Event();

  @override
  List<Object?> get props => [];
}

class Kids_Event_LoadKids extends Kids_Event {
  const Kids_Event_LoadKids();
}

class Kids_Event_AddKid extends Kids_Event {
  const Kids_Event_AddKid({required this.kid});

  final Kid kid;

  @override
  List<Object?> get props => [kid];
}

class Kids_Event_UpdateKid extends Kids_Event {
  const Kids_Event_UpdateKid({required this.kid});

  final Kid kid;

  @override
  List<Object?> get props => [kid];
}

class Kids_Event_DeleteKid extends Kids_Event {
  const Kids_Event_DeleteKid({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}
