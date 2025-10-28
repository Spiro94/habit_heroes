import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/models/kid_points.dart';
import '../../../../../shared/models/reward.dart';
import '../../../../blocs/kids_dashboard/bloc.dart';
import 'kid_selection_dialog.dart';

class KidsDashboard_Widget_RewardsTab extends StatelessWidget {
  const KidsDashboard_Widget_RewardsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KidsDashboard_Bloc, KidsDashboard_State>(
      builder: (context, state) {
        if (state.loadStatus == LoadStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.loadStatus == LoadStatus.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Error: ${state.loadErrorMessage ?? "Unknown error"}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<KidsDashboard_Bloc>().add(
                      const KidsDashboard_Event_LoadData(),
                    );
                  },
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kids Points Overview
              _buildKidsPointsSection(state),
              const SizedBox(height: 24),

              // Available Rewards
              const Text(
                'Recompensas Disponibles',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              if (state.rewards.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Text(
                      'No hay recompensas disponibles',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.rewards.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final reward = state.rewards[index];
                    return _buildRewardCard(context, state, reward);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildKidsPointsSection(KidsDashboard_State state) {
    if (state.kidsPoints.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Puntos por Niño',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: state.kidsPoints.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final kidPoints = state.kidsPoints[index];
              final color = kidPoints.kidColor != null
                  ? Color(
                      int.parse(kidPoints.kidColor!.replaceFirst('#', '0xff')),
                    )
                  : Colors.blue;

              return Container(
                width: 140,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.withOpacity(0.8), color.withOpacity(0.6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      child: Text(
                        kidPoints.kidName.isNotEmpty
                            ? kidPoints.kidName[0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          kidPoints.kidName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${kidPoints.totalPoints} ⭐',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRewardCard(
    BuildContext context,
    KidsDashboard_State state,
    Reward reward,
  ) {
    final canRedeem = state.kidsPoints.any(
      (KidPoints kid) => kid.totalPoints >= reward.points,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: canRedeem ? const Color(0xFFEC4899) : Colors.grey[300]!,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: canRedeem
                  ? const Color(0xFFEC4899).withOpacity(0.1)
                  : Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.card_giftcard,
              size: 32,
              color: canRedeem ? const Color(0xFFEC4899) : Colors.grey,
            ),
          ),
          const SizedBox(width: 16),
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
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Color(0xFFFCD34D)),
                    const SizedBox(width: 4),
                    Text(
                      '${reward.points} puntos',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: canRedeem
                ? () => _showKidSelectionDialog(context, state, reward)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEC4899),
              disabledBackgroundColor: Colors.grey[300],
            ),
            child: Text(
              canRedeem ? 'Canjear' : 'No hay puntos',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  void _showKidSelectionDialog(
    BuildContext context,
    KidsDashboard_State state,
    Reward reward,
  ) {
    showDialog(
      context: context,
      builder: (context) => KidsDashboard_Widget_KidSelectionDialog(
        kids: state.kidsPoints,
        reward: reward,
        onKidSelected: (kidId) {
          context.read<KidsDashboard_Bloc>().add(
            KidsDashboard_Event_RedeemReward(rewardId: reward.id, kidId: kidId),
          );

          // Show success/error snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('¡Recompensa canjeada!'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
}
