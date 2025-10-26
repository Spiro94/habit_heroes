import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:gap/gap.dart';

import '../../../../../../shared/models/enums/days_of_week.dart';
import '../../../../../../shared/models/enums/part_of_day.dart';
import '../../../../../blocs/parent_tasks/bloc.dart';
import '../../../../../blocs/parent_tasks/events.dart';
import '../../../../../blocs/parent_tasks/state.dart';

@RoutePage()
class CreateTask_Page extends StatelessWidget {
  const CreateTask_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const CreateTask_Scaffold();
  }
}

class CreateTask_Scaffold extends StatefulWidget {
  const CreateTask_Scaffold({super.key});

  @override
  State<CreateTask_Scaffold> createState() => _CreateTask_ScaffoldState();
}

class _CreateTask_ScaffoldState extends State<CreateTask_Scaffold>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _pointsController = TextEditingController();
  late final FSelectController<String> _assigneeController;
  late final FDateFieldController _dateController;

  String? _assigneeId;
  bool _isSpecificDate = false;

  // Map to store FSelectTileGroupController for each day of week
  final Map<DaysOfWeek, FSelectTileGroupController<PartOfDay>> _dayControllers =
      {};

  @override
  void initState() {
    super.initState();
    _assigneeController = FSelectController<String>(vsync: this);
    _dateController = FDateFieldController(
      vsync: this,
      initialDate: DateTime.now(),
    );

    // Initialize controllers for all days
    for (final day in DaysOfWeek.values) {
      _dayControllers[day] = FSelectTileGroupController<PartOfDay>();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        prefixes: [
          FButton.icon(
            onPress: () {
              context.router.maybePop();
            },
            child: const Icon(Icons.arrow_back),
          ),
        ],
        title: const Text('Create Task'),
      ),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: [
            BlocBuilder<ParentTasks_Bloc, ParentTasks_State>(
              builder: (context, state) {
                if (state.status == ParentTasks_Status.loading) {
                  return const Center(child: FCircularProgress());
                }
                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        FTextField(
                          controller: _titleController,
                          label: const Text('Título'),
                          hint: 'Ingrese el título de la tarea',
                        ),
                        const Gap(16),
                        FSelect<String>(
                          controller: _assigneeController,
                          label: const Text('Responsable'),
                          items: {
                            for (final kid in state.kids) kid.id: kid.name,
                          },
                          onChange: (value) {
                            setState(() {
                              _assigneeId = value;
                            });
                          },
                        ),
                        const Gap(16),
                        FTextField(
                          controller: _pointsController,
                          label: const Text('Puntos'),
                          hint: '0',
                        ),
                        const Gap(24),
                        FCheckbox(
                          label: const Text('Tarea para fecha específica'),
                          description: const Text(
                            'Marcar si es para un día específico',
                          ),
                          value: _isSpecificDate,
                          onChange: (value) {
                            setState(() {
                              _isSpecificDate = value;
                              if (!value) {
                                _dateController.value = null;
                              }
                            });
                          },
                        ),
                        const Gap(16),
                        if (_isSpecificDate)
                          _buildSpecificDatePicker()
                        else
                          _buildWeekdaySchedule(),
                        const Gap(32),
                        FButton(
                          onPress: () => _handleSubmit(context),
                          child: const Text('Crear Tarea'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Build specific date picker
  Widget _buildSpecificDatePicker() {
    return FDateField.calendar(
      controller: _dateController,
      label: const Text('Fecha específica'),
      description: const Text('Selecciona la fecha para esta tarea'),
      hint: 'Seleccionar fecha',
    );
  }

  /// Build weekday schedule with time of day options for each day
  Widget _buildWeekdaySchedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Programación semanal',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const Gap(8),
        const Text(
          'Selecciona los días y partes del día para la tarea',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const Gap(16),
        ...DaysOfWeek.values.map((day) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: FSelectTileGroup<PartOfDay>(
              selectController: _dayControllers[day]!,
              label: Text(day.fullName),
              semanticsLabel: day.fullName,
              divider: FItemDivider.full,
              children: PartOfDay.values.map((partOfDay) {
                return FSelectTile<PartOfDay>(
                  title: Text(partOfDay.name),
                  value: partOfDay,
                );
              }).toList(),
            ),
          );
        }),
      ],
    );
  }

  /// Handle form submission
  void _handleSubmit(BuildContext context) {
    // Validate title
    if (_titleController.text.isEmpty) {
      _showError(context, 'El título es requerido');
      return;
    }

    // Validate assignee
    if (_assigneeId == null) {
      _showError(context, 'Selecciona un responsable');
      return;
    }

    // Parse and validate points
    final points = int.tryParse(_pointsController.text);
    if (points == null || points < 0) {
      _showError(context, 'Ingrese puntos válidos (número >= 0)');
      return;
    }

    // Build list of schedules
    final schedules = <TaskScheduleInput>[];

    if (_isSpecificDate) {
      // Validate specific date
      if (_dateController.value == null) {
        _showError(context, 'Selecciona una fecha');
        return;
      }

      // Single schedule for specific date
      schedules.add(
        TaskScheduleInput(
          kidId: _assigneeId!,
          specificDate: _dateController.value,
        ),
      );
    } else {
      // Validate weekday schedule - check if any day has selections
      var hasAnySchedule = false;
      for (final controller in _dayControllers.values) {
        if (controller.value.isNotEmpty) {
          hasAnySchedule = true;
          break;
        }
      }

      if (!hasAnySchedule) {
        _showError(context, 'Selecciona al menos un día y parte del día');
        return;
      }

      // Collect all day+time combinations as schedules
      for (final entry in _dayControllers.entries) {
        final day = entry.key;
        final controller = entry.value;
        final selectedTimesOfDay = controller.value;

        if (selectedTimesOfDay.isEmpty) continue;

        for (final timeOfDay in selectedTimesOfDay) {
          schedules.add(
            TaskScheduleInput(
              kidId: _assigneeId!,
              daysOfWeek: [_dayOfWeekToInt(day)],
              timeOfDay: timeOfDay.key,
            ),
          );
        }
      }
    }

    // Create ONE task with MULTIPLE schedules
    context.read<ParentTasks_Bloc>().add(
          ParentTasks_Event_AddTask(
            title: _titleController.text,
            points: points,
            description: null,
            schedules: schedules,
          ),
        );

    // Navigate back
    context.router.maybePop();
  }

  /// Convert DaysOfWeek enum to int (matching PostgreSQL day of week)
  /// 0=Sunday, 1=Monday, 2=Tuesday, 3=Wednesday, 4=Thursday, 5=Friday,
  /// 6=Saturday
  int _dayOfWeekToInt(DaysOfWeek day) {
    switch (day) {
      case DaysOfWeek.sunday:
        return 0;
      case DaysOfWeek.monday:
        return 1;
      case DaysOfWeek.tuesday:
        return 2;
      case DaysOfWeek.wednesday:
        return 3;
      case DaysOfWeek.thursday:
        return 4;
      case DaysOfWeek.friday:
        return 5;
      case DaysOfWeek.saturday:
        return 6;
    }
  }

  /// Show error message
  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _pointsController.dispose();
    _assigneeController.dispose();
    _dateController.dispose();
    for (final controller in _dayControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}
