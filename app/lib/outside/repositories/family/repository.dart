import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/models/app_user.dart';
import '../base.dart';

class Family_Repository extends Repository_Base {
  Family_Repository({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  @override
  Future<void> init() async {}

  Future<void> createFamily(String familyId) async {
    await _supabaseClient.from('families').insert({'id': familyId});
  }

  Future<void> addUserToFamily(String familyId, String userId) async {
    await _supabaseClient.from('family_members').insert({
      'family_id': familyId,
      'user_id': userId,
    });
  }

  Future<List<AppUser>> getFamilyMembers(String familyId) async {
    final familyMembers = await _supabaseClient
        .from('family_members')
        .select('user_id')
        .eq('family_id', familyId);

    final userIds = familyMembers.map((e) => e['user_id'] as String).toList();

    if (userIds.isEmpty) {
      return [];
    }

    final response = await _supabaseClient
        .from('users')
        .select()
        .filter('id', 'in', userIds);

    return (response as List)
        .map((e) => AppUser.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
