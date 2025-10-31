import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../outside/theme/theme.dart';
import '../../../../../../shared/extensions/days_of_week_extension.dart';
import '../../../../../../shared/models/enums/days_of_week.dart';
import '../../../../../../shared/models/enums/part_of_day.dart';
import '../../../../../../shared/models/kid.dart';
import '../../../../../blocs/parent_tasks/bloc.dart';
import '../../../../../blocs/parent_tasks/events.dart';
import '../../../../../blocs/parent_tasks/state.dart';
import '../../../../../i18n/translations.g.dart';
import 'widgets/kid_dropdown.dart';
import 'widgets/listeners.dart';
import 'widgets/points_field.dart';
import 'widgets/schedule_type_toggle.dart';
import 'widgets/specific_date_picker.dart';
import 'widgets/submit_button.dart';
import 'widgets/title_field.dart';
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
              final day = dayInt.toDaysOfWeek();
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

  @override
  Widget build(BuildContext context) {
    return CreateTask_Listeners(
      onLoadEditingDataSuccess: () {
        final state = BlocProvider.of<ParentTasks_Bloc>(context).state;
        _prefillFormWithEditingData(state);
      },
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
              if (state.status == ParentTasks_Status.loading) {
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
                      CreateTask_Widget_TitleField(
                        controller: _titleController,
                      ),
                      const Gap(24),
                      // Kid Dropdown
                      CreateTask_Widget_KidDropdown(
                        selectedKid: _selectedKid,
                        kids: state.kids,
                        onChanged: (kid) {
                          setState(() {
                            _selectedKid = kid;
                          });
                        },
                      ),
                      const Gap(24),
                      // Points Field
                      CreateTask_Widget_PointsField(
                        controller: _pointsController,
                      ),
                      const Gap(24),
                      // Divider
                      Divider(
                        height: 1,
                        color: context.solidColors.divider,
                        thickness: 1,
                      ),
                      const Gap(24),
                      // Schedule Type Toggle
                      CreateTask_Widget_ScheduleTypeToggle(
                        isSpecificDate: _isSpecificDate,
                        onChanged: (value) {
                          setState(() {
                            _isSpecificDate = value;
                            if (!_isSpecificDate) {
                              _selectedDate = null;
                            }
                          });
                        },
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
                          isCreating: !_isEditing,
                        ),
                      const Gap(32),
                      // Submit Button
                      CreateTask_Widget_SubmitButton(
                        isEditing: _isEditing,
                        onPressed: () => _handleSubmit(context),
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
              daysOfWeek: [day.toInt()],
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

  @override
  void dispose() {
    _titleController.dispose();
    _pointsController.dispose();
    _dateErrorNotifier.dispose();
    _scheduleErrorNotifier.dispose();
    super.dispose();
  }
}
