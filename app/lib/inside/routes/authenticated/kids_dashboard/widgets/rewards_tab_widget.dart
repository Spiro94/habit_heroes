import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/models/kid_points.dart';
import '../../../../../shared/models/reward.dart';
import '../../../../blocs/kids_dashboard/bloc.dart';
import '../../../../i18n/translations.g.dart';
import 'kid_selection_dialog.dart';
import 'kids_points_section.dart';
import 'reward_card.dart';

class KidsDashboard_Widget_RewardsTab extends StatelessWidget {
  const KidsDashboard_Widget_RewardsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<KidsDashboard_Bloc, KidsDashboard_State>(
        builder: (context, state) {
          final translations = context.t;
          final kids = translations.kidsDashboard;
          final common = translations.common;

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
                    state.loadErrorMessage != null
                        ? common.errorWithMessage(
                            message: state.loadErrorMessage!,
                          )
                        : common.unknownError,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<KidsDashboard_Bloc>().add(
                        const KidsDashboard_Event_LoadData(),
                      );
                    },
                    child: Text(kids.rewards.retry),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KidsDashboard_Widget_KidsPointsSection(
                    kidsPoints: state.kidsPoints,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    kids.rewards.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (state.rewards.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Text(
                          kids.rewards.empty,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
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
                        return KidsDashboard_Widget_RewardCard(
                          reward: reward,
                          kidsPoints: state.kidsPoints,
                          onRedeem: () => _showKidSelectionDialog(
                            context,
                            state.kidsPoints,
                            reward,
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showKidSelectionDialog(
    BuildContext context,
    List<KidPoints> kidsPoints,
    Reward reward,
  ) {
    final kids = context.t.kidsDashboard;

    showDialog<void>(
      context: context,
      builder: (_) => KidsDashboard_Widget_KidSelectionDialog(
        kids: kidsPoints,
        reward: reward,
        onKidSelected: (kidId) {
          context.read<KidsDashboard_Bloc>().add(
            KidsDashboard_Event_RedeemReward(rewardId: reward.id, kidId: kidId),
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(kids.rewards.successSnack),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
}
