import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import '../../../outside/repositories/account_deletion/account_deletion_repository.dart';
import 'event.dart';
import 'state.dart';

class AccountDeletion_Bloc
    extends Bloc<AccountDeletion_Event, AccountDeletion_State> {
  AccountDeletion_Bloc({required AccountDeletion_Repository repository})
    : _repository = repository,
      super(const AccountDeletion_State.idle()) {
    on<AccountDeletion_Event_Submit>(_onSubmit);
    on<AccountDeletion_Event_Check>(_onCheck);
  }

  final AccountDeletion_Repository _repository;
  final _log = Logger('AccountDeletion_Bloc');

  Future<void> _onCheck(
    AccountDeletion_Event_Check event,
    Emitter<AccountDeletion_State> emit,
  ) async {
    try {
      final hasPending = await _repository.hasPendingDeletionRequest();
      emit(state.copyWith(hasPendingRequest: hasPending));
    } catch (e, st) {
      _log.warning('Failed to check deletion request', e, st);
      // Keep silent failure; do not change UI if check fails.
    }
  }

  Future<void> _onSubmit(
    AccountDeletion_Event_Submit event,
    Emitter<AccountDeletion_State> emit,
  ) async {
    emit(
      state.copyWith(
        status: AccountDeletion_Status.loading,
        errorMessage: null,
      ),
    );
    try {
      final ok = await _repository.requestAccountDeletion(
        event.email,
        reason: event.reason,
      );
      if (ok) {
        emit(state.copyWith(status: AccountDeletion_Status.success));
      } else {
        emit(
          state.copyWith(
            status: AccountDeletion_Status.failure,
            errorMessage: () =>
                'Ya existe una solicitud de eliminación para este correo.',
          ),
        );
      }
    } catch (e, st) {
      _log.warning('Failed to submit deletion request', e, st);
      emit(
        state.copyWith(
          status: AccountDeletion_Status.failure,
          errorMessage: () =>
              'Error al enviar la solicitud. Intenta nuevamente.',
        ),
      );
    }
  }
}
