import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../outside/theme/theme.dart';
import '../../../../../../shared/models/reward.dart' show Reward;
import '../../../../../blocs/parent_rewards/bloc.dart';
import '../../../../../blocs/parent_rewards/events.dart';
import '../../../../../blocs/parent_rewards/state.dart';
import '../../../../router.dart';

@RoutePage()
class ParentRewardsListPage extends StatelessWidget {
  const ParentRewardsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ParentRewardsList_Scaffold();
  }
}

class ParentRewardsList_Scaffold extends StatefulWidget {
  const ParentRewardsList_Scaffold({super.key});

  @override
  State<ParentRewardsList_Scaffold> createState() =>
      _ParentRewardsList_ScaffoldState();
}

class _ParentRewardsList_ScaffoldState
    extends State<ParentRewardsList_Scaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recompensas',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: context.colors.pointsGold.start,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.router.maybePop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Nueva Recompensa'),
              onPressed: () =>
                  context.router.push(ParentCreateRewardRoute()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: context.colors.pointsGold.start,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ParentRewards_Bloc, ParentRewards_State>(
        builder: (context, state) {
          if (state.loadStatus == ParentRewards_LoadStatus.loading ||
              state.loadStatus == ParentRewards_LoadStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.loadStatus == ParentRewards_LoadStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.loadErrorMessage}'),
                  const Gap(16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ParentRewards_Bloc>().add(
                            const ParentRewards_Event_LoadRewards(),
                          );
                    },
                    child: const Text('Intentar de nuevo'),
                  ),
                ],
              ),
            );
          }

          if (state.rewards.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.card_giftcard,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const Gap(16),
                  const Text('No hay recompensas'),
                  const Gap(8),
                  const Text('Crea tu primera recompensa'),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            itemCount: state.rewards.length,
            itemBuilder: (context, index) {
              final reward = state.rewards[index];
              return ParentRewardsList_Widget_RewardCard(
                reward: reward,
                onEdit: () {
                  context.router.push(
                    ParentCreateRewardRoute(reward: reward),
                  );
                },
                onDelete: () {
                  _showDeleteConfirmation(context, reward.id);
                },
              );
            },
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String rewardId) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Recompensa'),
        content: const Text(
          '¿Está seguro de que desea eliminar esta recompensa?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              context.read<ParentRewards_Bloc>().add(
                    ParentRewards_Event_DeleteReward(rewardId: rewardId),
                  );
              Navigator.pop(context);
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}

class ParentRewardsList_Widget_RewardCard extends StatelessWidget {
  const ParentRewardsList_Widget_RewardCard({
    required this.reward,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final Reward reward;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reward.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (reward.description != null) ...[
                        const Gap(8),
                        Text(
                          reward.description!,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.pointsGold.start.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: context.colors.pointsGold.start,
                      ),
                      const Gap(4),
                      Text(
                        '${reward.points} puntos',
                        style: TextStyle(
                          color: context.colors.pointsGold.start,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: onEdit,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
