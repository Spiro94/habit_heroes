import 'package:flutter_test/flutter_test.dart';
import 'package:habit_heroes/shared/models/task_completion.dart';

void main() {
  group('TaskCompletion', () {
    test('can be deserialized from JSON', () {
      final taskCompletion = TaskCompletion.fromJson(const {
        'id': '1',
        'task_id': 'task1',
        'kid_id': 'user1',
        'completed_at': '2023-01-01T00:00:00.000Z',
      });

      expect(taskCompletion.id, '1');
      expect(taskCompletion.taskId, 'task1');
      expect(taskCompletion.kidId, 'user1');
      expect(
        taskCompletion.completedAt,
        DateTime.parse('2023-01-01T00:00:00.000Z'),
      );
    });

    test('can be serialized to JSON', () {
      final taskCompletion = TaskCompletion(
        id: '1',
        taskId: 'task1',
        kidId: 'user1',
        completedAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );

      final json = taskCompletion.toJson();

      expect(json['id'], '1');
      expect(json['task_id'], 'task1');
      expect(json['kid_id'], 'user1');
      expect(json['completed_at'], '2023-01-01T00:00:00.000Z');
    });

    test('supports value equality', () {
      final taskCompletion1 = TaskCompletion(
        id: '1',
        taskId: 'task1',
        kidId: 'user1',
        completedAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );
      final taskCompletion2 = TaskCompletion(
        id: '1',
        taskId: 'task1',
        kidId: 'user1',
        completedAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );
      final taskCompletion3 = TaskCompletion(
        id: '2',
        taskId: 'task2',
        kidId: 'user2',
        completedAt: DateTime.parse('2023-01-02T00:00:00.000Z'),
      );

      expect(taskCompletion1, equals(taskCompletion2));
      expect(taskCompletion1, isNot(equals(taskCompletion3)));
    });
  });
}
