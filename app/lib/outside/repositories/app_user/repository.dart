import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/models/app_user.dart';
import '../base.dart';

abstract class AppUser_Repository extends Repository_Base {
  Future<AppUser> createAppUser({required AppUser appUser});

  Future<AppUser?> getAppUser({required String id});

  Future<AppUser> updateAppUser({required AppUser appUser});

  Future<void> deleteAppUser({required String id});
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
        .from('profiles')
        .insert(appUser.toJson())
        .select()
        .single();
    return AppUser.fromJson(response);
  }

  @override
  Future<AppUser?> getAppUser({required String id}) async {
    log.info('getAppUser');
    final response = await _supabaseClient
        .from('profiles')
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
        .from('profiles')
        .update(appUser.toJson())
        .eq('id', appUser.id)
        .select()
        .single();
    return AppUser.fromJson(response);
  }

  @override
  Future<void> deleteAppUser({required String id}) async {
    log.info('deleteAppUser');
    await _supabaseClient.from('profiles').delete().eq('id', id);
  }
}
