import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/models/enums/part_of_day.dart';
import '../../../../../shared/models/today_task.dart';
import '../../../../blocs/kids_dashboard/bloc.dart';

class KidsDashboard_Widget_TasksTab extends StatelessWidget {
  const KidsDashboard_Widget_TasksTab({super.key});

  PartOfDay _getCurrentPartOfDay() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return PartOfDay.morning;
    } else if (hour < 18) {
      return PartOfDay.afternoon;
    } else {
      return PartOfDay.night;
    }
  }

  IconData _getPartOfDayIcon(PartOfDay partOfDay) {
    switch (partOfDay) {
      case PartOfDay.morning:
        return Icons.wb_sunny;
      case PartOfDay.afternoon:
        return Icons.wb_cloudy;
      case PartOfDay.night:
        return Icons.nightlight_round;
    }
  }

  Color _getKidColor(String? color) {
    if (color == null) return const Color(0xFF6366F1);

    try {
      return Color(int.parse(color.replaceFirst('#', '0xFF')));
    } catch (e) {
      return const Color(0xFF6366F1);
    }
  }

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

        final tasks = state.todayTasks;
        final currentPartOfDay = _getCurrentPartOfDay();

        if (tasks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 64,
                  color: Colors.green[300],
                ),
                const SizedBox(height: 16),
                const Text(
                  '¡No hay tareas para hoy!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Disfruta tu día libre',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        // Group tasks by part of day
        final tasksByPartOfDay = <String, List<TodayTask>>{};
        for (final task in tasks) {
          tasksByPartOfDay.putIfAbsent(task.timeOfDay, () => []).add(task);
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Header
              _buildDateHeader(),
              const SizedBox(height: 24),

              // Part of Day Sections
              ...PartOfDay.values.map((partOfDay) {
                final partOfDayTasks = tasksByPartOfDay[partOfDay.key] ?? [];
                return _buildPartOfDaySection(
                  partOfDay: partOfDay,
                  tasks: partOfDayTasks,
                  isCurrentSection: partOfDay == currentPartOfDay,
                  context: context,
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDateHeader() {
    final now = DateTime.now();
    final weekdays = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo',
    ];
    final months = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre',
    ];

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            weekdays[now.weekday - 1],
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 4),
          Text(
            '${now.day} de ${months[now.month - 1]}',
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

  Widget _buildPartOfDaySection({
    required PartOfDay partOfDay,
    required List<TodayTask> tasks,
    required bool isCurrentSection,
    required BuildContext context,
  }) {
    if (tasks.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Part of Day Header
        Container(
          margin: const EdgeInsets.only(bottom: 16, top: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isCurrentSection
                ? const Color(0xFFEC4899).withValues(alpha: 0.2)
                : Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isCurrentSection
                  ? const Color(0xFFEC4899)
                  : Colors.grey[300]!,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Icon(
                _getPartOfDayIcon(partOfDay),
                color: isCurrentSection
                    ? const Color(0xFFEC4899)
                    : Colors.grey[600],
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                partOfDay.displayName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isCurrentSection
                      ? const Color(0xFFEC4899)
                      : Colors.grey[800],
                ),
              ),
              if (isCurrentSection) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEC4899),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Ahora',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),

        // Tasks
        ...tasks.map((task) => _buildTaskCard(task: task, context: context)),
      ],
    );
  }

  Widget _buildTaskCard({
    required TodayTask task,
    required BuildContext context,
  }) {
    final isCompleted = task.status == 'completed';
    final isSkipped = task.status == 'skipped';
    final kidColor = _getKidColor(task.kidColor);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCompleted
            ? Colors.green[50]
            : isSkipped
            ? Colors.grey[100]
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompleted
              ? Colors.green
              : isSkipped
              ? Colors.grey
              : kidColor,
          width: 2,
        ),
        boxShadow: [
          if (!isSkipped)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Row(
        children: [
          // Kid avatar/name
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: kidColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                task.kidName[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Task info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.kidName,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
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
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Points badge
          Container(
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
                  '${task.points}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Checkbox
          Checkbox(
            value: isCompleted,
            onChanged: isCompleted
                ? null
                : (value) {
                    if (value == true) {
                      context.read<KidsDashboard_Bloc>().add(
                        KidsDashboard_Event_CompleteTask(
                          instanceId: task.instanceId,
                        ),
                      );
                    }
                  },
          ),
        ],
      ),
    );
  }
}
