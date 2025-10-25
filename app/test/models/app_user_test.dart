import 'package:flutter_test/flutter_test.dart';

import 'package:habit_heroes/shared/models/app_user.dart';

void main() {
  group('AppUser', () {
    test('supports value equality', () {
      expect(
        const AppUser(
          id: '1',
          email: 'test@test.com',
          displayName: 'Test User',
          role: UserRole.parent,
          familyId: 'fam1',
        ),
        const AppUser(
          id: '1',
          email: 'test@test.com',
          displayName: 'Test User',
          role: UserRole.parent,
          familyId: 'fam1',
        ),
      );
    });

    test('props are correct', () {
      expect(
        const AppUser(
          id: '1',
          email: 'test@test.com',
          displayName: 'Test User',
          role: UserRole.parent,
          familyId: 'fam1',
        ).props,
        ['1', 'test@test.com', 'Test User', UserRole.parent, 'fam1'],
      );
    });

    test('fromJson creates a valid model', () {
      final json = {
        'id': '1',
        'email': 'test@test.com',
        'name': 'Test User',
        'role': 'parent',
        'family_id': 'fam1',
      };
      final user = AppUser.fromJson(json);
      expect(user.id, '1');
      expect(user.email, 'test@test.com');
      expect(user.displayName, 'Test User');
      expect(user.role, UserRole.parent);
      expect(user.familyId, 'fam1');
    });

    test('toJson creates a valid map', () {
      const user = AppUser(
        id: '1',
        email: 'test@test.com',
        displayName: 'Test User',
        role: UserRole.parent,
        familyId: 'fam1',
      );
      final json = user.toJson();
      expect(json['id'], '1');
      expect(json['email'], 'test@test.com');
      expect(json['name'], 'Test User');
      expect(json['role'], 'parent');
      expect(json['family_id'], 'fam1');
    });
  });
}
