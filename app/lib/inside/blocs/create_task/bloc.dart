import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../outside/repositories/app_user/repository.dart';
import '../../../outside/repositories/tasks/repository.dart';
import '../../../shared/models/task.dart';
import '../auth/bloc.dart';
import '../base.dart';
import 'events.dart';
import 'state.dart';

class CreateTask_Bloc extends Bloc_Base<CreateTask_Event, CreateTask_State> {
  CreateTask_Bloc({
    required AppUser_Repository appUserRepository,
    required Task_Repository taskRepository,
    required this.authBloc,
    required CreateTask_State initialState,
  }) : _appUserRepository = appUserRepository,
       _taskRepository = taskRepository,
       super(initialState) {
    on<CreateTask_Event_LoadKids>(_onLoadKids, transformer: sequential());
    on<CreateTask_Event_CreateTask>(_onCreateTask, transformer: sequential());
  }

  final AppUser_Repository _appUserRepository;
  final Task_Repository _taskRepository;
  final Auth_Bloc authBloc;

  Future<void> _onLoadKids(
    CreateTask_Event_LoadKids event,
    Emitter<CreateTask_State> emit,
  ) async {
    emit(state.copyWith(status: CreateTask_Status.loading));
    try {
      final familyId = authBloc.state.family?.id;
      if (familyId == null) {
        throw Exception('User is not in a family');
      }
      final kids = await _appUserRepository.getFamilyMembers();
      emit(state.copyWith(status: CreateTask_Status.loaded, kids: kids));
    } catch (e, stackTrace) {
      log.warning('${event.runtimeType}: error', e, stackTrace);
      emit(
        state.copyWith(
          status: CreateTask_Status.error,
          errorMessage: e.toString,
        ),
      );
    }
  }

  Future<void> _onCreateTask(
    CreateTask_Event_CreateTask event,
    Emitter<CreateTask_State> emit,
  ) async {
    emit(state.copyWith(status: CreateTask_Status.loading));
    try {
      final familyId = authBloc.state.family?.id;
      if (familyId == null) {
        throw Exception('User is not in a family');
      }

      for (final partOfDay in event.partsOfDay) {
        final task = Task(
          id: const Uuid().v4(),
          familyId: familyId,
          title: event.title,
          points: event.points,
          partOfDay: partOfDay,
          isRepetitive: event.isRepetitive,
          dueDaysOfWeek: event.daysOfWeek.map((day) => day.index).toList(),
          assigneeId: event.assigneeId,
          createdAt: DateTime.now(),
        );

        await _taskRepository.createTask(task: task);
      }

      emit(state.copyWith(status: CreateTask_Status.loaded));
    } catch (e, stackTrace) {
      log.warning('${event.runtimeType}: error', e, stackTrace);
      emit(
        state.copyWith(
          status: CreateTask_Status.error,
          errorMessage: e.toString,
        ),
      );
    }
  }
}
