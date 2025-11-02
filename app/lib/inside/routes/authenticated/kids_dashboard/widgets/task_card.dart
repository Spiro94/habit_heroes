import 'package:flutter/material.dart';

import '../../../../../shared/models/today_task.dart';

class KidsDashboard_Widget_TaskCard extends StatelessWidget {
  const KidsDashboard_Widget_TaskCard({
    required this.task,
    required this.onComplete,
    required this.onUncomplete,
    super.key,
  });

  final TodayTask task;
  final VoidCallback onComplete;
  final VoidCallback onUncomplete;

  bool get _isCompleted => task.status == 'completed';
  bool get _isSkipped => task.status == 'skipped';

  @override
  Widget build(BuildContext context) {
    final kidColor = _resolveKidColor(task.kidColor);

    return GestureDetector(
      onTap: _isSkipped ? null : (_isCompleted ? onUncomplete : onComplete),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isCompleted
              ? Colors.green[50]
              : _isSkipped
              ? Colors.grey[100]
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isCompleted
                ? Colors.green
                : _isSkipped
                ? Colors.grey
                : kidColor,
            width: 2,
          ),
          boxShadow: [
            if (!_isSkipped)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            _KidAvatar(kidName: task.kidName, backgroundColor: kidColor),
            const SizedBox(width: 12),
            Expanded(
              child: _TaskInfo(task: task, isCompleted: _isCompleted),
            ),
            _PointsBadge(points: task.points),
            const SizedBox(width: 8),
            Icon(
              _isCompleted ? Icons.check_circle : Icons.circle_outlined,
              color: _isCompleted ? Colors.green : Colors.grey,
              size: 32,
            ),
          ],
        ),
      ),
    );
  }

  Color _resolveKidColor(String? color) {
    if (color == null) {
      return const Color(0xFF6366F1);
    }
    try {
      return Color(int.parse(color.replaceFirst('#', '0xFF')));
    } catch (_) {
      return const Color(0xFF6366F1);
    }
  }
}

class _KidAvatar extends StatelessWidget {
  const _KidAvatar({required this.kidName, required this.backgroundColor});

  final String kidName;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final initial = kidName.isNotEmpty ? kidName[0].toUpperCase() : '?';

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          initial,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _TaskInfo extends StatelessWidget {
  const _TaskInfo({required this.task, required this.isCompleted});

  final TodayTask task;
  final bool isCompleted;

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              task.kidName,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            if (task.specificTime != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.access_time, size: 12, color: Colors.blue[700]),
                    const SizedBox(width: 4),
                    Text(
                      _formatTime(task.specificTime!),
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 4),
        Text(
          task.taskTitle,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            decoration: isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        if (task.taskDescription != null &&
            task.taskDescription!.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            task.taskDescription!,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              decoration: isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ],
    );
  }
}

class _PointsBadge extends StatelessWidget {
  const _PointsBadge({required this.points});

  final int points;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFCD34D),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: Colors.white, size: 16),
          const SizedBox(width: 4),
          Text(
            '$points',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
