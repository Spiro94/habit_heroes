import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/models/app_user.dart';
import '../base.dart';

abstract class AppUser_Repository extends Repository_Base {
  Future<AppUser> createAppUser({required AppUser appUser});

  Future<AppUser?> getAppUser({required String id});

  Future<AppUser> updateAppUser({required AppUser appUser});

  Future<void> deleteAppUser({required String id});

  Future<List<AppUser>> getAppUsersByFamilyId({required String familyId});
}

class SupabaseAppUser_Repository extends AppUser_Repository {
  SupabaseAppUser_Repository({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  @override
  Future<void> init() async {}

  @override
  Future<AppUser> createAppUser({required AppUser appUser}) async {
    log.info('createAppUser');
    final response = await _supabaseClient
        .from('app_users')
        .insert(appUser.toJson())
        .select()
        .single();
    return AppUser.fromJson(response);
  }

  @override
  Future<AppUser?> getAppUser({required String id}) async {
    log.info('getAppUser');
    final response = await _supabaseClient
        .from('app_users')
        .select()
        .eq('id', id)
        .maybeSingle();
    if (response != null) return AppUser.fromJson(response);
    return null;
  }

  @override
  Future<AppUser> updateAppUser({required AppUser appUser}) async {
    log.info('updateAppUser');
    final response = await _supabaseClient
        .from('app_users')
        .update(appUser.toJson())
        .eq('id', appUser.id)
        .select()
        .single();
    return AppUser.fromJson(response);
  }

  @override
  Future<void> deleteAppUser({required String id}) async {
    log.info('deleteAppUser');
    await _supabaseClient.from('app_users').delete().eq('id', id);
  }

  @override
  Future<List<AppUser>> getAppUsersByFamilyId({
    required String familyId,
  }) async {
    log.info('getAppUsersByFamilyId');
    final response = await _supabaseClient
        .from('app_users')
        .select()
        .eq('family_id', familyId);
    return response.map(AppUser.fromJson).toList();
  }
}
