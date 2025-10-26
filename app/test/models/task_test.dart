import 'package:flutter_test/flutter_test.dart';
import 'package:habit_heroes/shared/models/task.dart';

void main() {
  group('Task', () {
    test('can be deserialized from JSON', () {
      final task = Task.fromJson(const {
        'id': '1',
        'family_id': 'family1',
        'title': 'Do dishes',
        'description': 'Wash all the dishes in the sink',
        'points': 10,
        'time_of_day': 'morning',
        'repeat': 'daily',
        'days_of_week': [1, 2, 3],
        'created_at': '2023-01-01T00:00:00.000Z',
      });

      expect(task.id, '1');
      expect(task.familyId, 'family1');
      expect(task.title, 'Do dishes');
      expect(task.description, 'Wash all the dishes in the sink');
      expect(task.points, 10);
      expect(task.partOfDay, TimeOfDayCategory.morning);
      expect(task.isRepetitive, Repetition.daily);
      expect(task.dueDaysOfWeek, [1, 2, 3]);
      expect(task.createdAt, DateTime.parse('2023-01-01T00:00:00.000Z'));
    });

    test('can be serialized to JSON', () {
      final task = Task(
        id: '1',
        familyId: 'family1',
        title: 'Do dishes',
        description: 'Wash all the dishes in the sink',
        points: 10,
        partOfDay: TimeOfDayCategory.morning,
        isRepetitive: Repetition.daily,
        dueDaysOfWeek: const [1, 2, 3],
        createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );

      final json = task.toJson();

      expect(json['id'], '1');
      expect(json['family_id'], 'family1');
      expect(json['title'], 'Do dishes');
      expect(json['description'], 'Wash all the dishes in the sink');
      expect(json['points'], 10);
      expect(json['time_of_day'], 'morning');
      expect(json['repeat'], 'daily');
      expect(json['days_of_week'], [1, 2, 3]);
      expect(json['created_at'], '2023-01-01T00:00:00.000Z');
    });

    test('supports value equality', () {
      final task1 = Task(
        id: '1',
        familyId: 'family1',
        title: 'Do dishes',
        description: 'Wash all the dishes in the sink',
        points: 10,
        partOfDay: TimeOfDayCategory.morning,
        isRepetitive: Repetition.daily,
        dueDaysOfWeek: const [1, 2, 3],
        createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );
      final task2 = Task(
        id: '1',
        familyId: 'family1',
        title: 'Do dishes',
        description: 'Wash all the dishes in the sink',
        points: 10,
        partOfDay: TimeOfDayCategory.morning,
        isRepetitive: Repetition.daily,
        dueDaysOfWeek: const [1, 2, 3],
        createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );
      final task3 = Task(
        id: '2',
        familyId: 'family2',
        title: 'Clean room',
        description: 'Tidy up your room',
        points: 20,
        partOfDay: TimeOfDayCategory.evening,
        isRepetitive: Repetition.weekly,
        dueDaysOfWeek: const [5],
        createdAt: DateTime.parse('2023-01-02T00:00:00.000Z'),
      );

      expect(task1, equals(task2));
      expect(task1, isNot(equals(task3)));
    });
  });
}
