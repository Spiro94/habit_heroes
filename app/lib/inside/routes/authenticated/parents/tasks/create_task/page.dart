import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:gap/gap.dart';

import '../../../../../../shared/models/enums/days_of_week.dart';
import '../../../../../../shared/models/enums/part_of_day.dart';
import '../../../../../blocs/create_task/bloc.dart';
import '../../../../../blocs/create_task/events.dart';
import '../../../../../blocs/parent_tasks/bloc.dart';
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
  final FSelectTileGroupController<DaysOfWeek> _daysController =
      FSelectTileGroupController<DaysOfWeek>();
  final FSelectTileGroupController<PartOfDay> _partsController =
      FSelectTileGroupController<PartOfDay>();
  late final FSelectController<String> _assigneeController;

  String? _assigneeId;
  bool _isRepetitive = false;

  @override
  void initState() {
    _assigneeController = FSelectController<String>(vsync: this);

    super.initState();
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
                        ),
                        const Gap(16),
                        FSelect<String>(
                          controller: _assigneeController,
                          label: const Text('Responsable'),
                          items: {
                            for (final kid in state.kids)
                              kid.id: kid.displayName,
                          },
                          onChange: (value) {
                            setState(() {
                              _assigneeId = value;
                            });
                          },
                        ),
                        const Gap(16),
                        Row(
                          children: [
                            Expanded(
                              child: FTextField(
                                controller: _pointsController,
                                label: const Text('Puntos'),
                              ),
                            ),
                            const Gap(16),
                            Expanded(
                              flex: 2,
                              child: FCheckbox(
                                label: const Text('Repetitiva'),
                                description: const Text(
                                  '¿Se repite cada semana?',
                                ),
                                value: _isRepetitive,
                                onChange: (value) {
                                  setState(() {
                                    _isRepetitive = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const Gap(16),
                        FSelectTileGroup<DaysOfWeek>(
                          selectController: _daysController,
                          label: const Text('Días de la semana'),
                          semanticsLabel: 'Días de la semana',
                          description: const Text(
                            'Selecciona día(s) de la semana',
                          ),
                          divider: FItemDivider.full,
                          onSelect: (selection) {
                            // single selection callback (optional)
                          },
                          children: DaysOfWeek.values.map((day) {
                            return FSelectTile<DaysOfWeek>(
                              title: Text(day.fullName),
                              value: day,
                            );
                          }).toList(),
                        ),
                        const Gap(16),
                        FSelectTileGroup<PartOfDay>(
                          selectController: _partsController,
                          label: const Text('Parte del día'),
                          description: const Text(
                            'Selecciona parte(s) del día',
                          ),
                          divider: FItemDivider.full,
                          children: PartOfDay.values.map((part) {
                            return FSelectTile<PartOfDay>(
                              title: Text(part.name),
                              value: part,
                            );
                          }).toList(),
                        ),
                        const Gap(32),
                        FButton(
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<CreateTask_Bloc>().add(
                                CreateTask_Event_CreateTask(
                                  title: _titleController.text,
                                  assigneeId: _assigneeId!,
                                  points: int.parse(_pointsController.text),
                                  isRepetitive: _isRepetitive,
                                  daysOfWeek: _daysController.value.toList(),
                                  partsOfDay: _partsController.value.toList(),
                                ),
                              );
                            }
                          },
                          child: const Text('Create Task'),
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

  @override
  void dispose() {
    _titleController.dispose();
    _pointsController.dispose();
    _daysController.dispose();
    _partsController.dispose();
    super.dispose();
  }
}
