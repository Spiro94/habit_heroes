import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../blocs/parent_tasks/bloc.dart';
import '../../../../../blocs/parent_tasks/events.dart';
import '../../../../../blocs/parent_tasks/state.dart';
import '../../../../../i18n/translations.g.dart';
import '../../../../../../outside/theme/theme.dart';
import '../../../../../../shared/models/enums/days_of_week.dart';
import '../../../../../../shared/models/enums/part_of_day.dart';
import '../../../../../../shared/models/kid.dart';
import '../../../../../../shared/widgets/all.dart';
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

class _CreateTask_ScaffoldState extends State<CreateTask_Scaffold> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _pointsController = TextEditingController();

  Kid? _selectedKid;
  DateTime? _selectedDate;

  bool _isSpecificDate = false;

  // Map to store selections for each day of week
  final Map<DaysOfWeek, Set<PartOfDay>> _dayControllers = {};

  // Error notifiers for custom validation
  final _dateErrorNotifier = ValueNotifier<String?>(null);
  final _scheduleErrorNotifier = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();

    // Initialize controllers for all days
    for (final day in DaysOfWeek.values) {
      _dayControllers[day] = {};
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
      _selectedKid = assignedKid;

      // Check if this is a specific date task (first schedule has specificDate)
      if (schedules.first.specificDate != null) {
        _isSpecificDate = true;
        _selectedDate = schedules.first.specificDate;
      } else {
        // It's a weekday schedule - map ALL schedules to controllers
        _isSpecificDate = false;

        // Clear all controllers first
        for (final day in _dayControllers.keys) {
          _dayControllers[day] = {};
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
                final currentSelections = _dayControllers[day] ?? {};
                _dayControllers[day] = {...currentSelections, part};
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
              // Show error dialog
              showDialog<void>(
                context: context,
                builder: (context) => HabitHeroes_Dialog(
                  title: t.tasks.errorCreatingTask,
                  dialogType: HabitHeroesDialogType.error,
                  icon: Icons.error_outline,
                  body: Text(
                    state.createTaskErrorMessage ?? t.tasks.errorCreatingTask,
                  ),
                  actions: [
                    HabitHeroesDialogAction(
                      label: t.kids.cancel,
                      isPrimary: true,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
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
              // Show error dialog
              showDialog<void>(
                context: context,
                builder: (context) => HabitHeroes_Dialog(
                  title: t.tasks.errorUpdatingTask,
                  dialogType: HabitHeroesDialogType.error,
                  icon: Icons.error_outline,
                  body: Text(
                    state.updateTaskErrorMessage ?? t.tasks.errorUpdatingTask,
                  ),
                  actions: [
                    HabitHeroesDialogAction(
                      label: t.kids.cancel,
                      isPrimary: true,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
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
              // Show error dialog
              showDialog<void>(
                context: context,
                builder: (context) => HabitHeroes_Dialog(
                  title: t.tasks.errorLoadingTask,
                  dialogType: HabitHeroesDialogType.error,
                  icon: Icons.error_outline,
                  body: Text(
                    state.loadEditingDataErrorMessage ??
                        t.tasks.errorLoadingTask,
                  ),
                  actions: [
                    HabitHeroesDialogAction(
                      label: t.kids.cancel,
                      isPrimary: true,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _isEditing ? t.tasks.updateTaskTitle : t.tasks.createTaskTitle,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          backgroundColor: context.colors.tasksBlue.start,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.router.maybePop(),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<ParentTasks_Bloc, ParentTasks_State>(
            builder: (context, state) {
              if (state.loadStatus == LoadStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Title Field
                      ColorfulTextField(
                        label: t.tasks.titleLabel,
                        hint: t.tasks.titleHint,
                        controller: _titleController,
                        gradient: context.colors.tasksBlue,
                        textCapitalization: TextCapitalization.words,
                        prefixIcon: const Icon(Icons.task),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return t.tasks.titleRequired;
                          }
                          return null;
                        },
                      ),
                      const Gap(24),
                      // Kid Dropdown
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            t.tasks.assignedTo,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<Kid>(
                            initialValue: _selectedKid,
                            decoration: InputDecoration(
                              hintText: t.tasks.assignedToHint,
                              filled: true,
                              fillColor: context.solidColors.surfaceVariant,
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: context.colors.tasksBlue.start,
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: context.solidColors.error,
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                            items: state.kids
                                .map(
                                  (kid) => DropdownMenuItem(
                                    value: kid,
                                    child: Text(kid.name),
                                  ),
                                )
                                .toList(),
                            onChanged: (kid) {
                              setState(() {
                                _selectedKid = kid;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return t.tasks.selectAKid;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const Gap(24),
                      // Points Field
                      ColorfulTextField(
                        label: t.tasks.points,
                        hint: t.tasks.pointsHint,
                        controller: _pointsController,
                        gradient: context.colors.pointsGold,
                        keyboardType: TextInputType.number,
                        prefixIcon: const Icon(Icons.star),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      if (t.tasks.pointsDescription.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          t.tasks.pointsDescription,
                          style: TextStyle(
                            fontSize: 12,
                            color: context.solidColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                      const Gap(24),
                      // Divider
                      Divider(
                        height: 1,
                        color: context.solidColors.divider,
                        thickness: 1,
                      ),
                      const Gap(24),
                      // Specific Date Checkbox
                      Container(
                        decoration: BoxDecoration(
                          color: context.solidColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: context.solidColors.border),
                        ),
                        child: CheckboxListTile(
                          value: _isSpecificDate,
                          onChanged: (value) {
                            setState(() {
                              _isSpecificDate = value ?? false;
                              if (!_isSpecificDate) {
                                _selectedDate = null;
                              }
                            });
                          },
                          title: Text(
                            t.tasks.specificDateTask,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            t.tasks.specificDateDescription,
                            style: TextStyle(
                              fontSize: 13,
                              color: context.solidColors.onSurfaceVariant,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: context.colors.tasksBlue.start,
                        ),
                      ),
                      const Gap(16),
                      // Date/Schedule Selection
                      if (_isSpecificDate)
                        CreateTask_Widget_SpecificDatePicker(
                          selectedDate: _selectedDate,
                          onDateChanged: (date) {
                            setState(() {
                              _selectedDate = date;
                            });
                          },
                          errorNotifier: _dateErrorNotifier,
                        )
                      else
                        CreateTask_Widget_WeekdaySchedule(
                          dayControllers: _dayControllers,
                          errorNotifier: _scheduleErrorNotifier,
                        ),
                      const Gap(32),
                      // Submit Button
                      SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () => _handleSubmit(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.colors.tasksBlue.start,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: Text(
                            _isEditing
                                ? t.tasks.updateButton
                                : t.tasks.createButton,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
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

    // Validate kid selection
    if (_selectedKid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.tasks.selectAKid),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Parse points (optional field, default to 0)
    final points = int.tryParse(_pointsController.text.trim()) ?? 0;

    // Build list of schedules
    final schedules = <TaskScheduleInput>[];

    if (_isSpecificDate) {
      // Validate specific date
      if (_selectedDate == null) {
        _dateErrorNotifier.value = t.tasks.selectDateError;
        return;
      }

      // Single schedule for specific date
      schedules.add(
        TaskScheduleInput(kidId: _selectedKid!.id, specificDate: _selectedDate),
      );
    } else {
      // Validate weekday schedule - check if any day has selections
      var hasAnySchedule = false;
      for (final daySet in _dayControllers.values) {
        if (daySet.isNotEmpty) {
          hasAnySchedule = true;
          break;
        }
      }

      if (!hasAnySchedule) {
        _scheduleErrorNotifier.value = t.tasks.scheduleError;
        return;
      }

      // Collect all day+time combinations as schedules
      for (final entry in _dayControllers.entries) {
        final day = entry.key;
        final selectedTimesOfDay = entry.value;

        if (selectedTimesOfDay.isEmpty) continue;

        for (final timeOfDay in selectedTimesOfDay) {
          schedules.add(
            TaskScheduleInput(
              kidId: _selectedKid!.id,
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
    _dateErrorNotifier.dispose();
    _scheduleErrorNotifier.dispose();
    super.dispose();
  }
}
