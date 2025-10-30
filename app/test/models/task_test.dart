import 'package:flutter_test/flutter_test.dart';
import 'package:habit_heroes/shared/models/enums/part_of_day.dart';
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
        'part_of_day': 'morning',
        'is_repetitive': true,
        'due_days_of_week': [1, 2, 3],
        'assignee_id': 'kid1',
        'created_at': '2023-01-01T00:00:00.000Z',
      });

      expect(task.id, '1');
      expect(task.familyId, 'family1');
      expect(task.title, 'Do dishes');
      expect(task.description, 'Wash all the dishes in the sink');
      expect(task.points, 10);
      expect(task.partOfDay, PartOfDay.morning);
      expect(task.isRepetitive, isTrue);
      expect(task.dueDaysOfWeek, [1, 2, 3]);
      expect(task.assigneeId, 'kid1');
      expect(task.createdAt, DateTime.parse('2023-01-01T00:00:00.000Z'));
    });

    test('can be serialized to JSON', () {
      final task = Task(
        id: '1',
        familyId: 'family1',
        title: 'Do dishes',
        description: 'Wash all the dishes in the sink',
        points: 10,
        partOfDay: PartOfDay.morning,
        isRepetitive: true,
        dueDaysOfWeek: const [1, 2, 3],
        assigneeId: 'kid1',
        createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );

      final json = task.toJson();

      expect(json['id'], '1');
      expect(json['family_id'], 'family1');
      expect(json['title'], 'Do dishes');
      expect(json['description'], 'Wash all the dishes in the sink');
      expect(json['points'], 10);
      expect(json['part_of_day'], 'morning');
      expect(json['is_repetitive'], true);
      expect(json['due_days_of_week'], [1, 2, 3]);
      expect(json['assignee_id'], 'kid1');
      expect(json['created_at'], '2023-01-01T00:00:00.000Z');
    });

    test('supports value equality', () {
      final task1 = Task(
        id: '1',
        familyId: 'family1',
        title: 'Do dishes',
        description: 'Wash all the dishes in the sink',
        points: 10,
        partOfDay: PartOfDay.morning,
        isRepetitive: true,
        dueDaysOfWeek: const [1, 2, 3],
        assigneeId: 'kid1',
        createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );
      final task2 = Task(
        id: '1',
        familyId: 'family1',
        title: 'Do dishes',
        description: 'Wash all the dishes in the sink',
        points: 10,
        partOfDay: PartOfDay.morning,
        isRepetitive: true,
        dueDaysOfWeek: const [1, 2, 3],
        assigneeId: 'kid1',
        createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );
      final task3 = Task(
        id: '2',
        familyId: 'family2',
        title: 'Clean room',
        description: 'Tidy up your room',
        points: 20,
        partOfDay: PartOfDay.afternoon,
        isRepetitive: false,
        dueDaysOfWeek: const [5],
        assigneeId: 'kid2',
        createdAt: DateTime.parse('2023-01-02T00:00:00.000Z'),
      );

      expect(task1, equals(task2));
      expect(task1, isNot(equals(task3)));
    });
  });
}
