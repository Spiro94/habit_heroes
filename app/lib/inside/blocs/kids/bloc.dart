import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../outside/repositories/kids/repository.dart';
import 'events.dart';
import 'state.dart';

class Kids_Bloc extends Bloc<Kids_Event, Kids_State> {
  final Kids_Repository _kidRepository;

  Kids_Bloc(this._kidRepository) : super(Kids_State.initial()) {
    on<Kids_Event_LoadKids>(_onLoadKids);
    on<Kids_Event_AddKid>(_onAddKid);
    on<Kids_Event_UpdateKid>(_onUpdateKid);
    on<Kids_Event_DeleteKid>(_onDeleteKid);
  }

  Future<void> _onLoadKids(
    Kids_Event_LoadKids event,
    Emitter<Kids_State> emit,
  ) async {
    emit(state.copyWith(status: Kids_Status.loading));
    try {
      final kids = await _kidRepository.getKidsForParent();
      emit(state.copyWith(status: Kids_Status.loaded, kids: kids));
    } catch (e) {
      emit(
        state.copyWith(
          status: Kids_Status.error,
          setErrorMessage: () => e.toString(),
        ),
      );
    }
  }

  Future<void> _onAddKid(
    Kids_Event_AddKid event,
    Emitter<Kids_State> emit,
  ) async {
    emit(state.copyWith(status: Kids_Status.loading));
    try {
      // Event contains a full Kid model
      await _kidRepository.createKid(kid: event.kid);
      final kids = await _kidRepository.getKidsForParent();
      emit(state.copyWith(status: Kids_Status.loaded, kids: kids));
    } catch (e) {
      emit(
        state.copyWith(
          status: Kids_Status.error,
          setErrorMessage: () => e.toString(),
        ),
      );
    }
  }

  Future<void> _onUpdateKid(
    Kids_Event_UpdateKid event,
    Emitter<Kids_State> emit,
  ) async {
    emit(state.copyWith(status: Kids_Status.loading));
    try {
      await _kidRepository.updateKid(kid: event.kid);
      final kids = await _kidRepository.getKidsForParent();
      emit(state.copyWith(status: Kids_Status.loaded, kids: kids));
    } catch (e) {
      emit(
        state.copyWith(
          status: Kids_Status.error,
          setErrorMessage: () => e.toString(),
        ),
      );
    }
  }

  Future<void> _onDeleteKid(
    Kids_Event_DeleteKid event,
    Emitter<Kids_State> emit,
  ) async {
    emit(state.copyWith(status: Kids_Status.loading));
    try {
      await _kidRepository.deleteKid(id: event.id);
      final kids = await _kidRepository.getKidsForParent();
      emit(state.copyWith(status: Kids_Status.loaded, kids: kids));
    } catch (e) {
      emit(
        state.copyWith(
          status: Kids_Status.error,
          setErrorMessage: () => e.toString(),
        ),
      );
    }
  }
}
