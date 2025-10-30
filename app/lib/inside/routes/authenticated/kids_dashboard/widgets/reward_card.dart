import 'package:flutter/material.dart';

import '../../../../../shared/models/kid_points.dart';
import '../../../../../shared/models/reward.dart';

class KidsDashboard_Widget_RewardCard extends StatelessWidget {
  const KidsDashboard_Widget_RewardCard({
    required this.reward,
    required this.kidsPoints,
    required this.onRedeem,
    super.key,
  });

  final Reward reward;
  final List<KidPoints> kidsPoints;
  final VoidCallback onRedeem;

  bool get _canRedeem =>
      kidsPoints.any((KidPoints kid) => kid.totalPoints >= reward.points);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: _canRedeem ? const Color(0xFFEC4899) : Colors.grey[300]!,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color:
                  _canRedeem
                      ? const Color(0xFFEC4899).withValues(alpha: 0.1)
                      : Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.card_giftcard,
              size: 32,
              color: _canRedeem ? const Color(0xFFEC4899) : Colors.grey,
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
            onPressed: _canRedeem ? onRedeem : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEC4899),
              disabledBackgroundColor: Colors.grey[300],
            ),
            child: Text(
              _canRedeem ? 'Canjear' : 'No hay puntos',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
