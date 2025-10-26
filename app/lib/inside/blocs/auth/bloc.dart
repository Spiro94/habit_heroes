import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../../../outside/repositories/app_user/repository.dart';
import '../../../outside/repositories/auth/repository.dart';
import '../../../outside/repositories/family/repository.dart';
import '../../../shared/models/app_user.dart';
import '../../../shared/models/family.dart';
import '../base.dart';
import 'events.dart';
import 'state.dart';

class Auth_Bloc extends Bloc_Base<Auth_Event, Auth_State> {
  Auth_Bloc({
    required AppUser_Repository appUserRepository,
    required Auth_Repository authRepository,
    required Family_Repository familyRepository,
    required Auth_State initialState,
  }) : _appUserRepository = appUserRepository,
       _authRepository = authRepository,
       _familyRepository = familyRepository,
       super(initialState) {
    on<Auth_Event_SignOut>(_onSignOut, transformer: sequential());
    on<Auth_Event_AccessTokenAdded>(
      _onAccessTokenAdded,
      transformer: sequential(),
    );
    on<Auth_Event_AccessTokenRemoved>(
      _onAccessTokenRemoved,
      transformer: sequential(),
    );
    on<Auth_Event_GetAccessTokenFromUri>(
      _getAccessTokenFromUri,
      transformer: sequential(),
    );
  }

  final AppUser_Repository _appUserRepository;
  final Auth_Repository _authRepository;
  final Family_Repository _familyRepository;

  Future<void> _onSignOut(
    Auth_Event_SignOut event,
    Emitter<Auth_State> emit,
  ) async {
    try {
      await _authRepository.signOut();
    } catch (e, stackTrace) {
      log.warning('${event.runtimeType}: error', e, stackTrace);
    } finally {
      await _tokenRemoved(emit);
    }
  }

  Future<void> _onAccessTokenAdded(
    Auth_Event_AccessTokenAdded event,
    Emitter<Auth_State> emit,
  ) async {
    final supabaseUser = _authRepository.getCurrentUser();

    if (supabaseUser == null) {
      emit(
        const Auth_State(
          status: Auth_Status.unauthenticated,
          accessToken: null,
        ),
      );
      return;
    }

    final appUser = await _appUserRepository.getAppUser(id: supabaseUser.id);

    if (appUser == null) {
      log.warning(
        'AppUser not found for id: ${supabaseUser.id}, creating a new one.',
      );
      // TODO: handle this case properly
    }

    // Fetch family model
    Family? family;
    try {
      family = await _familyRepository.getFamilyForUser(supabaseUser.id);
    } catch (e) {
      log.warning('Failed to fetch or create family: $e');
      family = null;
    }

    emit(
      Auth_State(
        status: Auth_Status.authenticated,
        accessToken: event.accessToken,
        appUser: appUser,
        family: family,
      ),
    );

    try {
      await _authRepository.updatesUsersInClients();
    } catch (e) {
      log.warning(e);
    }
  }

  Future<void> _onAccessTokenRemoved(
    Auth_Event_AccessTokenRemoved event,
    Emitter<Auth_State> emit,
  ) async {
    await _tokenRemoved(emit);
  }

  Future<void> _tokenRemoved(Emitter<Auth_State> emit) async {
    emit(
      const Auth_State(
        status: Auth_Status.unauthenticated,
        accessToken: null,
        appUser: null,
        family: null,
      ),
    );

    try {
      await _authRepository.updatesUsersInClients();
    } catch (e) {
      log.warning(e);
    }
  }

  Future<void> _getAccessTokenFromUri(
    Auth_Event_GetAccessTokenFromUri event,
    Emitter<Auth_State> emit,
  ) async {
    try {
      final accessToken = await _authRepository.getAccessTokenFromUri(
        uri: event.uri,
        code: event.code,
        refreshToken: event.refreshToken,
      );

      // After retrieving the access token, try to fetch the app user and
      // family so the authenticated state is fully populated.
      final supabaseUser = _authRepository.getCurrentUser();
      AppUser? appUser;
      Family? family;

      if (supabaseUser != null) {
        try {
          appUser = await _appUserRepository.getAppUser(id: supabaseUser.id);
        } catch (e) {
          log.warning('Failed to fetch AppUser after URI auth: $e');
        }

        try {
          family = await _familyRepository.getFamilyForUser(supabaseUser.id);
        } catch (e) {
          log.warning('Failed to fetch/create family after URI auth: $e');
        }
      }

      emit(
        Auth_State(
          status: Auth_Status.authenticated,
          accessToken: accessToken,
          appUser: appUser,
          family: family,
        ),
      );

      log.info('authenticated from URI');
      event.errorMessageCompleter.complete();
    } catch (e) {
      log.warning(e);

      // The redirect link after sign up seems to always be in this state, but
      // it doesn' affect the user, so we are ignoring this error.
      if (e is supabase.AuthException && e.code == 'flow_state_not_found') {
        event.errorMessageCompleter.complete();
        return;
      }

      event.errorMessageCompleter.complete(e.toString());
    }
  }
}
