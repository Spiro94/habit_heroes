import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/models/reward.dart';
import '../base.dart';

abstract class Reward_Repository extends Repository_Base {
  Future<Reward> createReward({required Reward reward});

  Future<Reward?> getReward({required String id});

  Future<Reward> updateReward({required Reward reward});

  Future<void> deleteReward({required String id});

  Future<List<Reward>> getRewardsByFamilyId({required String familyId});
}

class SupabaseReward_Repository extends Reward_Repository {
  SupabaseReward_Repository({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  @override
  Future<void> init() async {}

  @override
  Future<Reward> createReward({required Reward reward}) async {
    log.info('createReward');
    final response = await _supabaseClient
        .from('rewards')
        .insert(reward.toJson())
        .select()
        .single();
    return Reward.fromJson(response);
  }

  @override
  Future<Reward?> getReward({required String id}) async {
    log.info('getReward');
    final response = await _supabaseClient
        .from('rewards')
        .select()
        .eq('id', id)
        .single();
    return Reward.fromJson(response);
  }

  @override
  Future<Reward> updateReward({required Reward reward}) async {
    log.info('updateReward');
    final response = await _supabaseClient
        .from('rewards')
        .update(reward.toJson())
        .eq('id', reward.id)
        .select()
        .single();
    return Reward.fromJson(response);
  }

  @override
  Future<void> deleteReward({required String id}) async {
    log.info('deleteReward');
    await _supabaseClient.from('rewards').delete().eq('id', id);
  }

  @override
  Future<List<Reward>> getRewardsByFamilyId({required String familyId}) async {
    log.info('getRewardsByFamilyId');
    final response = await _supabaseClient
        .from('rewards')
        .select()
        .eq('parent_id', familyId);
    return response.map(Reward.fromJson).toList();
  }
}
