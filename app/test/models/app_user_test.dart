import 'package:flutter_test/flutter_test.dart';

import 'package:habit_heroes/shared/models/app_user.dart';

void main() {
  group('AppUser', () {
    test('supports value equality', () {
      expect(
        const AppUser(id: '1', displayName: 'Test User', role: UserRole.parent),
        const AppUser(id: '1', displayName: 'Test User', role: UserRole.parent),
      );
    });

    test('props are correct', () {
      expect(
        const AppUser(
          id: '1',
          displayName: 'Test User',
          role: UserRole.parent,
        ).props,
        ['1', 'Test User', UserRole.parent],
      );
    });

    test('fromJson creates a valid model', () {
      final json = {'id': '1', 'display_name': 'Test User', 'role': 'parent'};
      final user = AppUser.fromJson(json);
      expect(user.id, '1');
      expect(user.displayName, 'Test User');
      expect(user.role, UserRole.parent);
    });

    test('toJson creates a valid map', () {
      const user = AppUser(
        id: '1',
        displayName: 'Test User',
        role: UserRole.parent,
      );
      final json = user.toJson();
      expect(json['id'], '1');
      expect(json['display_name'], 'Test User');
      expect(json['role'], 'parent');
    });
  });
}
