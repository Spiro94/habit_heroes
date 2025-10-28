import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../outside/theme/theme.dart';
import '../../../../../../shared/models/reward.dart' show Reward;
import '../../../../../../shared/widgets/all.dart';
import '../../../../../blocs/parent_rewards/bloc.dart';
import '../../../../../blocs/parent_rewards/events.dart';
import '../../../../../blocs/parent_rewards/state.dart';
import '../../../../router.dart';
import '../../../../widgets/colorful_card.dart';

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
              onPressed: () => context.router.push(ParentCreateRewardRoute()),
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
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: context.colors.pointsGold.toLinearGradient(),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.card_giftcard,
                      size: 64,
                      color: Colors.white,
                    ),
                  ),
                  const Gap(24),
                  const Text(
                    'No hay recompensas',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Gap(8),
                  Text(
                    'Crea tu primera recompensa',
                    style: TextStyle(
                      color: context.solidColors.onSurfaceVariant,
                    ),
                  ),
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
                  context.router.push(ParentCreateRewardRoute(reward: reward));
                },
                onDelete: () {
                  _showDeleteConfirmation(context, reward.id);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            context.router.push(const ParentRedemptionsHistoryRoute()),
        icon: const Icon(Icons.history),
        label: const Text('Historial'),
        backgroundColor: context.colors.pointsGold.start,
        foregroundColor: Colors.white,
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String rewardId) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return HabitHeroes_Dialog(
          title: 'Eliminar Recompensa',
          dialogType: HabitHeroesDialogType.error,
          icon: Icons.delete_outline,
          body: const Text(
            '¿Está seguro de que desea eliminar esta recompensa?',
          ),
          actions: [
            HabitHeroesDialogAction(
              label: 'Cancelar',
              onPressed: () => Navigator.pop(context),
            ),
            HabitHeroesDialogAction(
              label: 'Eliminar',
              isPrimary: true,
              onPressed: () {
                context.read<ParentRewards_Bloc>().add(
                  ParentRewards_Event_DeleteReward(rewardId: rewardId),
                );
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ColorfulCard(
        gradient: context.colors.pointsGold,
        borderRadius: 16,
        shadowBlur: 12,
        shadowOffset: const Offset(0, 4),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              // Icon badge
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.card_giftcard,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const Gap(16),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reward.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    if (reward.description != null) ...[
                      const Gap(4),
                      Text(
                        reward.description!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                    const Gap(8),
                    // Points badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.white),
                          const Gap(4),
                          Text(
                            '${reward.points} puntos',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              // Action buttons
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Material(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: onEdit,
                      customBorder: const CircleBorder(),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.edit, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                  const Gap(8),
                  Material(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: onDelete,
                      customBorder: const CircleBorder(),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
