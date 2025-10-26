import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../outside/repositories/app_user/repository.dart';
import '../../../outside/repositories/tasks/repository.dart';
import '../../../shared/models/app_user.dart';
import '../base.dart';
import 'events.dart';
import 'state.dart';

class ParentTasks_Bloc extends Bloc_Base<ParentTasks_Event, ParentTasks_State> {
  ParentTasks_Bloc({
    required AppUser_Repository appUserRepository,
    required Task_Repository taskRepository,
    required ParentTasks_State initialState,
  }) : _appUserRepository = appUserRepository,
       _taskRepository = taskRepository,
       super(initialState) {
    on<ParentTasks_Event_LoadTasks>(_onLoadTasks, transformer: sequential());
    on<ParentTasks_Event_AddTask>(_onAddTask, transformer: sequential());
    on<ParentTasks_Event_UpdateTask>(_onUpdateTask, transformer: sequential());
    on<ParentTasks_Event_DeleteTask>(_onDeleteTask, transformer: sequential());
  }

  final AppUser_Repository _appUserRepository;

  final Task_Repository _taskRepository;

  Future<void> _onLoadTasks(
    ParentTasks_Event_LoadTasks event,
    Emitter<ParentTasks_State> emit,
  ) async {
    emit(state.copyWith(status: ParentTasks_Status.loading));
    try {
      final tasks = await _taskRepository.getTasks();
      final familyMembers = await _appUserRepository.getFamilyMembers();
      final kids = familyMembers
          .where((user) => user.role == UserRole.kid)
          .toList();
      emit(
        state.copyWith(
          status: ParentTasks_Status.loaded,
          tasks: tasks,
          kids: kids,
        ),
      );
    } catch (e, stackTrace) {
      log.warning('${event.runtimeType}: error', e, stackTrace);
      emit(
        state.copyWith(
          status: ParentTasks_Status.error,
          setErrorMessage: e.toString,
        ),
      );
    }
  }

  Future<void> _onAddTask(
    ParentTasks_Event_AddTask event,
    Emitter<ParentTasks_State> emit,
  ) async {
    // TODO: Implement add task logic
  }

  Future<void> _onUpdateTask(
    ParentTasks_Event_UpdateTask event,
    Emitter<ParentTasks_State> emit,
  ) async {
    // TODO: Implement update task logic
  }

  Future<void> _onDeleteTask(
    ParentTasks_Event_DeleteTask event,
    Emitter<ParentTasks_State> emit,
  ) async {
    // TODO: Implement delete task logic
  }
}
