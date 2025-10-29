import 'package:flutter/material.dart';

import '../../../../../shared/models/kid_points.dart';

class KidsDashboard_Widget_KidsPointsSection extends StatelessWidget {
  const KidsDashboard_Widget_KidsPointsSection({
    super.key,
    required this.kidsPoints,
  });

  final List<KidPoints> kidsPoints;

  @override
  Widget build(BuildContext context) {
    if (kidsPoints.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Puntos por Nino',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: kidsPoints.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final kidPoints = kidsPoints[index];
              final color = _resolveKidColor(kidPoints);

              return Container(
                width: 130,
                padding: const EdgeInsets.all(12),
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: Text(
                            _initials(kidPoints.kidName),
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      kidPoints.kidName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Puntos Acumulados',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${kidPoints.totalPoints} pts',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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

  Color _resolveKidColor(KidPoints kidPoints) {
    if (kidPoints.kidColor != null) {
      return Color(int.parse(kidPoints.kidColor!.replaceFirst('#', '0xff')));
    }
    return Colors.blue;
  }

  String _initials(String name) {
    if (name.isEmpty) {
      return '';
    }

    final parts = name.split(' ');
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }

    final firstInitial = parts.first.isNotEmpty
        ? parts.first.substring(0, 1)
        : '';
    final lastInitial = parts.last.isNotEmpty ? parts.last.substring(0, 1) : '';
    return (firstInitial + lastInitial).toUpperCase();
  }
}
