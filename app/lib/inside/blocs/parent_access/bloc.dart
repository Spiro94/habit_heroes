import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../outside/repositories/parent_access/repository.dart';
import '../base.dart';
import 'events.dart';
import 'state.dart';

class ParentAccess_Bloc
    extends Bloc_Base<ParentAccess_Event, ParentAccess_State> {
  ParentAccess_Bloc({required ParentAccess_Repository parentAccessRepository})
    : _parentAccessRepository = parentAccessRepository,
      super(const ParentAccess_State(status: ParentAccess_Status.initial)) {
    on<ParentAccess_Event_CheckPinExists>(
      _onCheckPinExists,
      transformer: sequential(),
    );
    on<ParentAccess_Event_CreatePin>(_onCreatePin, transformer: sequential());
    on<ParentAccess_Event_VerifyPin>(_onVerifyPin, transformer: sequential());
    on<ParentAccess_Event_UpdatePin>(_onUpdatePin, transformer: sequential());
  }

  final ParentAccess_Repository _parentAccessRepository;

  Future<void> _onCheckPinExists(
    ParentAccess_Event_CheckPinExists event,
    Emitter<ParentAccess_State> emit,
  ) async {
    try {
      emit(state.copyWith(status: ParentAccess_Status.checking));

      final hasPin = await _parentAccessRepository.hasPinConfigured();

      emit(
        state.copyWith(status: ParentAccess_Status.checked, pinExists: hasPin),
      );
    } catch (e, stackTrace) {
      log.warning('${event.runtimeType}: error', e, stackTrace);
      emit(
        state.copyWith(
          status: ParentAccess_Status.checkError,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onCreatePin(
    ParentAccess_Event_CreatePin event,
    Emitter<ParentAccess_State> emit,
  ) async {
    try {
      emit(state.copyWith(status: ParentAccess_Status.creating));

      if (event.pin.length != 4) {
        emit(
          state.copyWith(
            status: ParentAccess_Status.createError,
            errorMessage: 'El PIN debe tener 4 dígitos',
          ),
        );
        return;
      }

      await _parentAccessRepository.createPin(pin: event.pin);

      emit(
        state.copyWith(
          status: ParentAccess_Status.createSuccess,
          pinExists: true,
        ),
      );
    } catch (e, stackTrace) {
      log.warning('${event.runtimeType}: error', e, stackTrace);
      emit(
        state.copyWith(
          status: ParentAccess_Status.createError,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onVerifyPin(
    ParentAccess_Event_VerifyPin event,
    Emitter<ParentAccess_State> emit,
  ) async {
    try {
      emit(state.copyWith(status: ParentAccess_Status.verifying));

      final isValid = await _parentAccessRepository.verifyPin(pin: event.pin);

      if (isValid) {
        emit(state.copyWith(status: ParentAccess_Status.verifySuccess));
      } else {
        emit(
          state.copyWith(
            status: ParentAccess_Status.verifyError,
            errorMessage: 'PIN incorrecto. Intenta de nuevo.',
          ),
        );
      }
    } catch (e, stackTrace) {
      log.warning('${event.runtimeType}: error', e, stackTrace);
      emit(
        state.copyWith(
          status: ParentAccess_Status.verifyError,
          errorMessage: e is StateError
              ? 'No hay PIN configurado'
              : e.toString(),
        ),
      );
    }
  }

  Future<void> _onUpdatePin(
    ParentAccess_Event_UpdatePin event,
    Emitter<ParentAccess_State> emit,
  ) async {
    try {
      emit(state.copyWith(status: ParentAccess_Status.updating));

      if (event.newPin.length != 4) {
        emit(
          state.copyWith(
            status: ParentAccess_Status.updateError,
            errorMessage: 'El PIN debe tener 4 dígitos',
          ),
        );
        return;
      }

      final isCurrentPinValid = await _parentAccessRepository.verifyPin(
        pin: event.currentPin,
      );

      if (!isCurrentPinValid) {
        emit(
          state.copyWith(
            status: ParentAccess_Status.updateError,
            errorMessage: 'El PIN actual es incorrecto',
          ),
        );
        return;
      }

      await _parentAccessRepository.updatePin(
        currentPin: event.currentPin,
        newPin: event.newPin,
      );

      emit(state.copyWith(status: ParentAccess_Status.updateSuccess));
    } catch (e, stackTrace) {
      log.warning('${event.runtimeType}: error', e, stackTrace);
      emit(
        state.copyWith(
          status: ParentAccess_Status.updateError,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
