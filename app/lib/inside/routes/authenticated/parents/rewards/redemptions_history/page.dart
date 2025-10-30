import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../../../outside/theme/theme.dart';
import '../../../../../../shared/models/reward_redemption.dart';
import '../../../../../blocs/parent_rewards/bloc.dart';
import '../../../../../blocs/parent_rewards/state.dart';

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
        title: const Text(
          'Historial de Canjes',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
          if (state.redemptionLoadStatus ==
                  ParentRewards_RedemptionLoadStatus.loading ||
              state.redemptionLoadStatus ==
                  ParentRewards_RedemptionLoadStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.redemptionLoadStatus ==
              ParentRewards_RedemptionLoadStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.redemptionLoadErrorMessage}'),
                  const Gap(16),
                  ElevatedButton(
                    onPressed: () {
                      // Trigger reload
                    },
                    child: const Text('Intentar de nuevo'),
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
                  const Text('No hay canjes registrados'),
                  const Gap(8),
                  const Text('Los canjes de recompensas apareceran aqui'),
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
    final rewardName = redemption.rewardName ?? 'Recompensa desconocida';
    final kidName = redemption.kidName ?? 'Nino desconocido';

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
                        'Canjeado por: $kidName',
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
                        '${redemption.pointsCost} puntos',
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
