import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:gap/gap.dart';

import '../../../../../../shared/models/enums/days_of_week.dart';
import '../../../../../../shared/models/enums/part_of_day.dart';
import '../../../../../../shared/models/kid.dart';
import '../../../../../blocs/parent_tasks/bloc.dart';
import '../../../../../blocs/parent_tasks/events.dart';
import '../../../../../blocs/parent_tasks/state.dart';
import '../../../../../i18n/translations.g.dart';
import '../../../../router.dart';
import 'widgets/specific_date_picker.dart';
import 'widgets/weekday_schedule.dart';

@RoutePage()
class CreateTask_Page extends StatelessWidget {
  const CreateTask_Page({super.key, this.taskScheduleId});

  final String? taskScheduleId;

  @override
  Widget build(BuildContext context) {
    return CreateTask_Scaffold(taskScheduleId: taskScheduleId);
  }
}

class CreateTask_Scaffold extends StatefulWidget {
  const CreateTask_Scaffold({super.key, this.taskScheduleId});

  final String? taskScheduleId;

  @override
  State<CreateTask_Scaffold> createState() => _CreateTask_ScaffoldState();
}

class _CreateTask_ScaffoldState extends State<CreateTask_Scaffold>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _pointsController = TextEditingController();
  late final FSelectController<Kid> _assigneeController;
  late final FDateFieldController _dateController;

  bool _isSpecificDate = false;

  // Map to store FSelectTileGroupController for each day of week
  final Map<DaysOfWeek, FSelectTileGroupController<PartOfDay>> _dayControllers =
      {};

  // Error notifiers for custom validation
  final _dateErrorNotifier = ValueNotifier<String?>(null);
  final _scheduleErrorNotifier = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    _assigneeController = FSelectController<Kid>(vsync: this);
    _dateController = FDateFieldController(
      vsync: this,
      initialDate: DateTime.now(),
    );

    // Initialize controllers for all days
    for (final day in DaysOfWeek.values) {
      _dayControllers[day] = FSelectTileGroupController<PartOfDay>();
    }

    // If editing, dispatch event to load schedule/template
    if (widget.taskScheduleId != null) {
      context.read<ParentTasks_Bloc>().add(
        ParentTasks_Event_LoadTaskForEditing(
          scheduleId: widget.taskScheduleId!,
        ),
      );
    }
  }

  void _prefillFormWithEditingData(ParentTasks_State state) {
    final schedules = state.editingSchedules;
    final template = state.editingTemplate;

    if (schedules.isEmpty) return;

    setState(() {
      // Prefill title/points if template available
      if (template != null) {
        _titleController.text = template.title;
        _pointsController.text = template.points.toString();
      }

      // Prefill assigned kid from first schedule
      final assignedKid = state.kids.firstWhere(
        (kid) => kid.id == schedules.first.kidId,
        orElse: () => state.kids.first,
      );
      _assigneeController.value = assignedKid;

      // Check if this is a specific date task (first schedule has specificDate)
      if (schedules.first.specificDate != null) {
        _isSpecificDate = true;
        _dateController.value = schedules.first.specificDate;
      } else {
        // It's a weekday schedule - map ALL schedules to controllers
        _isSpecificDate = false;

        // Clear all controllers first
        for (final controller in _dayControllers.values) {
          controller.value = {};
        }

        // Process each schedule and add to the appropriate day controller
        for (final schedule in schedules) {
          if (schedule.daysOfWeek != null && schedule.timeOfDay != null) {
            for (final dayInt in schedule.daysOfWeek!) {
              final day = _intToDaysOfWeek(dayInt);
              if (day != null) {
                final part = PartOfDay.values.firstWhere(
                  (p) => p.key == schedule.timeOfDay!.key,
                  orElse: () => PartOfDay.morning,
                );
                // Add to existing selections for this day
                final currentSelections = _dayControllers[day]?.value ?? {};
                _dayControllers[day]?.value = {...currentSelections, part};
              }
            }
          }
        }
      }
    });
  }

  bool get _isEditing => widget.taskScheduleId != null;

  DaysOfWeek? _intToDaysOfWeek(int i) {
    switch (i) {
      case 0:
        return DaysOfWeek.sunday;
      case 1:
        return DaysOfWeek.monday;
      case 2:
        return DaysOfWeek.tuesday;
      case 3:
        return DaysOfWeek.wednesday;
      case 4:
        return DaysOfWeek.thursday;
      case 5:
        return DaysOfWeek.friday;
      case 6:
        return DaysOfWeek.saturday;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ParentTasks_Bloc, ParentTasks_State>(
          listenWhen: (previous, current) =>
              previous.createTaskStatus != current.createTaskStatus,
          listener: (context, state) {
            if (state.createTaskStatus == CreateTaskStatus.error) {
              // Show error snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.createTaskErrorMessage ?? t.tasks.errorCreatingTask,
                  ),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 4),
                ),
              );
            } else if (state.createTaskStatus == CreateTaskStatus.success) {
              // Task was successfully created, navigate back
              context.router.navigate(const TaskList_Route());
            }
          },
        ),
        BlocListener<ParentTasks_Bloc, ParentTasks_State>(
          listenWhen: (previous, current) =>
              previous.updateTaskStatus != current.updateTaskStatus,
          listener: (context, state) {
            if (state.updateTaskStatus == UpdateTaskStatus.error) {
              // Show error snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.updateTaskErrorMessage ??
                        t.tasks.errorUpdatingTask,
                  ),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 4),
                ),
              );
            } else if (state.updateTaskStatus == UpdateTaskStatus.success) {
              // Task was successfully updated, navigate back
              context.router.navigate(const TaskList_Route());
            }
          },
        ),
        BlocListener<ParentTasks_Bloc, ParentTasks_State>(
          listenWhen: (previous, current) =>
              previous.loadEditingDataStatus != current.loadEditingDataStatus,
          listener: (context, state) {
            if (state.loadEditingDataStatus == LoadEditingDataStatus.loaded) {
              // Prefill form with editing data
              _prefillFormWithEditingData(state);
            } else if (state.loadEditingDataStatus ==
                LoadEditingDataStatus.error) {
              // Show error snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.loadEditingDataErrorMessage ??
                        t.tasks.errorLoadingTask,
                  ),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 4),
                ),
              );
            }
          },
        ),
      ],
      child: FScaffold(
        header: FHeader.nested(
          prefixes: [
            FButton.icon(
              onPress: () {
                context.router.maybePop();
              },
              child: const Icon(Icons.arrow_back),
            ),
          ],
          title: Text(_isEditing ? t.tasks.updateTaskTitle : t.tasks.createTaskTitle),
        ),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            children: [
              BlocBuilder<ParentTasks_Bloc, ParentTasks_State>(
                builder: (context, state) {
                  if (state.loadStatus == LoadStatus.loading) {
                    return const Center(child: FCircularProgress());
                  }
                  return Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          FTextFormField(
                            controller: _titleController,
                            label: Text(t.tasks.titleLabel),
                            hint: t.tasks.titleHint,
                            textCapitalization: TextCapitalization.words,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return t.tasks.titleRequired;
                              }
                              return null;
                            },
                          ),
                          const Gap(16),
                          FSelect<Kid>.rich(
                            controller: _assigneeController,
                            label: Text(t.tasks.assignedTo),
                            hint: t.tasks.assignedToHint,
                            validator: (value) {
                              if (value == null) {
                                return t.tasks.selectAKid;
                              }
                              return null;
                            },
                            format: (value) => value.name,
                            children: state.kids
                                .map(
                                  (kid) => FSelectItem<Kid>(
                                    value: kid,
                                    title: Text(kid.name),
                                  ),
                                )
                                .toList(),
                          ),
                          const Gap(16),
                          FTextField(
                            controller: _pointsController,
                            label: Text(t.tasks.points),
                            description: Text(
                              t.tasks.pointsDescription,
                            ),
                            hint: t.tasks.pointsHint,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                          const Gap(8),
                          const FDivider(),
                          const Gap(8),
                          FCheckbox(
                            label: Text(t.tasks.specificDateTask),
                            description: Text(
                              t.tasks.specificDateDescription,
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
                            CreateTask_Widget_SpecificDatePicker(
                              controller: _dateController,
                              errorNotifier: _dateErrorNotifier,
                            )
                          else
                            CreateTask_Widget_WeekdaySchedule(
                              dayControllers: _dayControllers,
                              errorNotifier: _scheduleErrorNotifier,
                            ),
                          const Gap(32),
                          FButton(
                            onPress: () => _handleSubmit(context),
                            child: Text(
                              _isEditing ? t.tasks.updateButton : t.tasks.createButton,
                            ),
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
      ),
    );
  }

  /// Handle form submission
  void _handleSubmit(BuildContext context) {
    // Clear previous validation errors
    _dateErrorNotifier.value = null;
    _scheduleErrorNotifier.value = null;

    // Validate form fields
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Parse points (optional field, default to 0)
    final points = int.tryParse(_pointsController.text.trim()) ?? 0;

    // Build list of schedules
    final schedules = <TaskScheduleInput>[];

    if (_isSpecificDate) {
      // Validate specific date
      if (_dateController.value == null) {
        _dateErrorNotifier.value = t.tasks.selectDateError;
        return;
      }

      // Single schedule for specific date
      schedules.add(
        TaskScheduleInput(
          kidId: _assigneeController.value!.id,
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
        _scheduleErrorNotifier.value =
            t.tasks.scheduleError;
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
              kidId: _assigneeController.value!.id,
              daysOfWeek: [_dayOfWeekToInt(day)],
              timeOfDay: timeOfDay.key,
            ),
          );
        }
      }
    }

    // If editing, dispatch update to template and schedules
    final editingTemplate = context
        .read<ParentTasks_Bloc>()
        .state
        .editingTemplate;
    if (editingTemplate != null) {
      context.read<ParentTasks_Bloc>().add(
        ParentTasks_Event_UpdateTask(
          templateId: editingTemplate.id,
          title: _titleController.text.trim(),
          points: points,
          description: null,
          schedules: schedules,
        ),
      );
    } else {
      // Create ONE task with MULTIPLE schedules
      context.read<ParentTasks_Bloc>().add(
        ParentTasks_Event_AddTask(
          title: _titleController.text.trim(),
          points: points,
          description: null,
          schedules: schedules,
        ),
      );
    }

    // Navigation handled by BlocListener on success
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

  @override
  void dispose() {
    _titleController.dispose();
    _pointsController.dispose();
    _assigneeController.dispose();
    _dateController.dispose();
    _dateErrorNotifier.dispose();
    _scheduleErrorNotifier.dispose();
    for (final controller in _dayControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}
