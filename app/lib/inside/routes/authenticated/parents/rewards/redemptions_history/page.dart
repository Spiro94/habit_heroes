import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../../../outside/theme/theme.dart';
import '../../../../../../shared/models/reward_redemption.dart';
import '../../../../../blocs/parent_rewards/bloc.dart';
import '../../../../../blocs/parent_rewards/state.dart';
import '../../../../../i18n/translations.g.dart';

@RoutePage()
class ParentRedemptionsHistoryPage extends StatelessWidget {
  const ParentRedemptionsHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ParentRedemptionsHistory_Scaffold();
  }
}

class ParentRedemptionsHistory_Scaffold extends StatefulWidget {
  const ParentRedemptionsHistory_Scaffold({super.key});

  @override
  State<ParentRedemptionsHistory_Scaffold> createState() =>
      _ParentRedemptionsHistory_ScaffoldState();
}

class _ParentRedemptionsHistory_ScaffoldState
    extends State<ParentRedemptionsHistory_Scaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.t.parentRewards.redemptionsHistory.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: context.colors.pointsGold.start,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.router.maybePop(),
        ),
      ),
      body: BlocBuilder<ParentRewards_Bloc, ParentRewards_State>(
        builder: (context, state) {
          final translations = context.t;
          final parentRewards = translations.parentRewards.redemptionsHistory;
          final common = translations.common;

          if (state.redemptionLoadStatus ==
                  ParentRewards_RedemptionLoadStatus.loading ||
              state.redemptionLoadStatus ==
                  ParentRewards_RedemptionLoadStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.redemptionLoadStatus ==
              ParentRewards_RedemptionLoadStatus.error) {
            final errorMessage = state.redemptionLoadErrorMessage;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    errorMessage != null
                        ? common.errorWithMessage(message: errorMessage)
                        : common.unknownError,
                  ),
                  const Gap(16),
                  ElevatedButton(
                    onPressed: () {
                      // Trigger reload
                    },
                    child: Text(parentRewards.retryButton),
                  ),
                ],
              ),
            );
          }

          if (state.redemptions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const Gap(16),
                  Text(parentRewards.emptyTitle),
                  const Gap(8),
                  Text(parentRewards.emptySubtitle),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            itemCount: state.redemptions.length,
            itemBuilder: (context, index) {
              final redemption = state.redemptions[index];
              return ParentRedemptionsHistory_Widget_RedemptionCard(
                redemption: redemption,
              );
            },
          );
        },
      ),
    );
  }
}

class ParentRedemptionsHistory_Widget_RedemptionCard extends StatelessWidget {
  const ParentRedemptionsHistory_Widget_RedemptionCard({
    required this.redemption,
    super.key,
  });

  final RewardRedemption redemption;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final formattedDate = dateFormat.format(redemption.redeemedAt.toLocal());
    final parentRewards = context.t.parentRewards.redemptionsHistory;
    final rewardName = redemption.rewardName ?? parentRewards.unknownReward;
    final kidName = redemption.kidName ?? parentRewards.unknownKid;
    final redeemedBy = parentRewards.redeemedBy(name: kidName);
    final pointsLabel = parentRewards.points(points: redemption.pointsCost);

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
                        rewardName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        redeemedBy,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.pointsGold.start
                        .withValues(alpha: 0.2),
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
                        pointsLabel,
                        style: TextStyle(
                          color: context.colors.pointsGold.start,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  formattedDate,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
