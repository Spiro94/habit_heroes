import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/models/enums/days_of_week.dart';
import '../../../../i18n/translations.g.dart';

class KidsDashboard_Widget_DateHeader extends StatelessWidget {
  const KidsDashboard_Widget_DateHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final weekday = DaysOfWeek.values[now.weekday - 1];
    final locale = Localizations.localeOf(context);
    final monthName = DateFormat.MMMM(locale.toString()).format(now);
    final dateLabel = context.t.kidsDashboard.dateHeader.date(
      day: now.day,
      month: monthName,
    );

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            weekday.fullName,
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 4),
          Text(
            dateLabel,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
