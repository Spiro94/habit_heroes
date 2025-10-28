import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../outside/theme/theme.dart';
import '../../../../../../shared/models/reward.dart';
import '../../../../../blocs/parent_rewards/bloc.dart';
import '../../../../../blocs/parent_rewards/events.dart';
import '../../../../../blocs/parent_rewards/state.dart';

@RoutePage()
class ParentCreateRewardPage extends StatelessWidget {
  const ParentCreateRewardPage({this.reward, super.key});

  final Reward? reward;

  @override
  Widget build(BuildContext context) {
    return ParentCreateReward_Scaffold(reward: reward);
  }
}

class ParentCreateReward_Scaffold extends StatefulWidget {
  const ParentCreateReward_Scaffold({this.reward, super.key});

  final Reward? reward;

  @override
  State<ParentCreateReward_Scaffold> createState() =>
      _ParentCreateReward_ScaffoldState();
}

class _ParentCreateReward_ScaffoldState
    extends State<ParentCreateReward_Scaffold> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _pointsController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.reward?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.reward?.description ?? '');
    _pointsController =
        TextEditingController(text: widget.reward?.points.toString() ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _pointsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.reward != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Editar Recompensa' : 'Nueva Recompensa',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: context.colors.pointsGold.start,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.router.maybePop(),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ParentRewards_Bloc, ParentRewards_State>(
            listenWhen: (previous, current) =>
                previous.createStatus != current.createStatus,
            listener: (context, state) {
              if (state.createStatus == ParentRewards_CreateStatus.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Recompensa creada')),
                );
                context.router.maybePop();
              } else if (state.createStatus ==
                  ParentRewards_CreateStatus.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.createErrorMessage ??
                          'Error al crear recompensa',
                    ),
                  ),
                );
              }
            },
          ),
          BlocListener<ParentRewards_Bloc, ParentRewards_State>(
            listenWhen: (previous, current) =>
                previous.updateStatus != current.updateStatus,
            listener: (context, state) {
              if (state.updateStatus == ParentRewards_UpdateStatus.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Recompensa actualizada')),
                );
                context.router.maybePop();
              } else if (state.updateStatus ==
                  ParentRewards_UpdateStatus.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.updateErrorMessage ??
                          'Error al actualizar recompensa',
                    ),
                  ),
                );
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Detalles de la Recompensa',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Gap(24),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre de la Recompensa',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const Gap(16),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descripción (Opcional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                maxLines: 3,
              ),
              const Gap(16),
              TextField(
                controller: _pointsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Puntos Requeridos',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.star),
                ),
              ),
              const Gap(32),
              BlocBuilder<ParentRewards_Bloc, ParentRewards_State>(
                builder: (context, state) {
                  final isLoading = isEditing
                      ? state.updateStatus == ParentRewards_UpdateStatus.updating
                      : state.createStatus == ParentRewards_CreateStatus.creating;

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colors.pointsGold.start,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: isLoading ? null : _submitForm,
                    child: Text(
                      isLoading
                          ? 'Guardando...'
                          : isEditing
                              ? 'Actualizar Recompensa'
                              : 'Crear Recompensa',
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

  void _submitForm() {
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();
    final pointsStr = _pointsController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingresa un nombre')),
      );
      return;
    }

    final points = int.tryParse(pointsStr);
    if (points == null || points <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor ingresa un número válido de puntos'),
        ),
      );
      return;
    }

    final isEditing = widget.reward != null;

    if (isEditing) {
      final updatedReward = Reward(
        id: widget.reward!.id,
        parentId: widget.reward!.parentId,
        name: name,
        description: description.isEmpty ? null : description,
        points: points,
        createdAt: widget.reward!.createdAt,
        updatedAt: DateTime.now(),
      );
      context.read<ParentRewards_Bloc>().add(
            ParentRewards_Event_UpdateReward(reward: updatedReward),
          );
    } else {
      final parentId =
          context.read<ParentRewards_Bloc>().state.rewards.isEmpty
              ? ''
              : context.read<ParentRewards_Bloc>().state.rewards.first.parentId;

      final newReward = Reward(
        id: '',
        parentId: parentId,
        name: name,
        description: description.isEmpty ? null : description,
        points: points,
        createdAt: DateTime.now(),
      );
      context.read<ParentRewards_Bloc>().add(
            ParentRewards_Event_AddReward(reward: newReward),
          );
    }
  }
}
