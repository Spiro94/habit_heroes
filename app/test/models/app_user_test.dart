import 'package:flutter_test/flutter_test.dart';

import 'package:habit_heroes/shared/models/app_user.dart';

void main() {
  group('AppUser', () {
    test('supports value equality', () {
      expect(
        const AppUser(id: '1', name: 'Test User', avatarUrl: 'avatar.png'),
        equals(
          const AppUser(
            id: '1',
            name: 'Test User',
            avatarUrl: 'avatar.png',
          ),
        ),
      );
    });

    test('props are correct', () {
      final createdAt = DateTime.parse('2023-01-01T00:00:00.000Z');
      final updatedAt = DateTime.parse('2023-01-02T00:00:00.000Z');
      expect(
        AppUser(
          id: '1',
          name: 'Test User',
          avatarUrl: 'avatar.png',
          createdAt: createdAt,
          updatedAt: updatedAt,
        ).props,
        ['1', 'Test User', 'avatar.png', createdAt, updatedAt],
      );
    });

    test('fromJson creates a valid model', () {
      final json = {
        'id': '1',
        'name': 'Test User',
        'avatar_url': 'https://example.com/avatar.png',
        'created_at': '2023-01-01T00:00:00.000Z',
        'updated_at': '2023-01-02T00:00:00.000Z',
      };
      final user = AppUser.fromJson(json);
      expect(user.id, '1');
      expect(user.name, 'Test User');
      expect(user.avatarUrl, 'https://example.com/avatar.png');
      expect(user.createdAt, DateTime.parse('2023-01-01T00:00:00.000Z'));
      expect(user.updatedAt, DateTime.parse('2023-01-02T00:00:00.000Z'));
    });

    test('toJson creates a valid map', () {
      final user = AppUser(
        id: '1',
        name: 'Test User',
        avatarUrl: 'https://example.com/avatar.png',
        createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
        updatedAt: DateTime.parse('2023-01-02T00:00:00.000Z'),
      );
      final json = user.toJson();
      expect(json['id'], '1');
      expect(json['name'], 'Test User');
      expect(json['avatar_url'], 'https://example.com/avatar.png');
      expect(json['created_at'], '2023-01-01T00:00:00.000Z');
      expect(json['updated_at'], '2023-01-02T00:00:00.000Z');
    });
  });
}
