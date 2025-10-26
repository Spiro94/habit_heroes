import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/models/kid.dart';
import '../base.dart';

abstract class Kid_Repository extends Repository_Base {
  Future<Kid> createKid({required Kid kid});

  Future<Kid?> getKid({required String id});

  Future<List<Kid>> getKidsForParent();

  Future<Kid> updateKid({required Kid kid});

  Future<void> deleteKid({required String id});
}

class SupabaseKid_Repository extends Kid_Repository {
  SupabaseKid_Repository({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  @override
  Future<void> init() async {}

  @override
  Future<Kid> createKid({required Kid kid}) async {
    log.info('createKid');
    final response = await _supabaseClient
        .from('kids')
        .insert(kid.toJson())
        .select()
        .single();
    return Kid.fromJson(response);
  }

  @override
  Future<Kid?> getKid({required String id}) async {
    log.info('getKid');
    final response = await _supabaseClient
        .from('kids')
        .select()
        .eq('id', id)
        .maybeSingle();
    if (response != null) return Kid.fromJson(response);
    return null;
  }

  @override
  Future<List<Kid>> getKidsForParent() async {
    log.info('getKidsForParent');
    // RLS policy automatically filters by parent_id = auth.uid()
    final response = await _supabaseClient
        .from('kids')
        .select()
        .order('order_index', ascending: true);

    return (response as List<dynamic>)
        .map((json) => Kid.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Kid> updateKid({required Kid kid}) async {
    log.info('updateKid');
    final response = await _supabaseClient
        .from('kids')
        .update(kid.toJson())
        .eq('id', kid.id)
        .select()
        .single();
    return Kid.fromJson(response);
  }

  @override
  Future<void> deleteKid({required String id}) async {
    log.info('deleteKid');
    await _supabaseClient.from('kids').delete().eq('id', id);
  }
}
