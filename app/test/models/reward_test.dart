import 'package:flutter_test/flutter_test.dart';
import 'package:habit_heroes/shared/models/reward.dart';

void main() {
  group('Reward', () {
    test('can be deserialized from JSON', () {
      final reward = Reward.fromJson(const {
        'id': '1',
        'family_id': 'family1',
        'name': 'Ice Cream',
        'points': 50,
        'created_at': '2023-01-01T00:00:00.000Z',
      });

      expect(reward.id, '1');
      expect(reward.familyId, 'family1');
      expect(reward.name, 'Ice Cream');
      expect(reward.points, 50);
      expect(reward.createdAt, DateTime.parse('2023-01-01T00:00:00.000Z'));
    });

    test('can be serialized to JSON', () {
      final reward = Reward(
        id: '1',
        familyId: 'family1',
        name: 'Ice Cream',
        points: 50,
        createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );

      final json = reward.toJson();

      expect(json['id'], '1');
      expect(json['family_id'], 'family1');
      expect(json['name'], 'Ice Cream');
      expect(json['points'], 50);
      expect(json['created_at'], '2023-01-01T00:00:00.000Z');
    });

    test('supports value equality', () {
      final reward1 = Reward(
        id: '1',
        familyId: 'family1',
        name: 'Ice Cream',
        points: 50,
        createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );
      final reward2 = Reward(
        id: '1',
        familyId: 'family1',
        name: 'Ice Cream',
        points: 50,
        createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );
      final reward3 = Reward(
        id: '2',
        familyId: 'family2',
        name: 'New Toy',
        points: 100,
        createdAt: DateTime.parse('2023-01-02T00:00:00.000Z'),
      );

      expect(reward1, equals(reward2));
      expect(reward1, isNot(equals(reward3)));
    });
  });
}
