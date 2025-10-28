import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/models/reward_redemption.dart';
import '../base.dart';

abstract class RewardRedemption_Repository extends Repository_Base {
  Future<List<RewardRedemption>> getRedemptionHistory({
    required String parentId,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<List<RewardRedemption>> getRedemptionsByKid({
    required String kidId,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<List<RewardRedemption>> getRedemptionsByReward({
    required String rewardId,
    DateTime? startDate,
    DateTime? endDate,
  });
}

class SupabaseRewardRedemption_Repository extends RewardRedemption_Repository {
  SupabaseRewardRedemption_Repository({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  @override
  Future<void> init() async {}

  @override
  Future<List<RewardRedemption>> getRedemptionHistory({
    required String parentId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    log.info('getRedemptionHistory');
    final kidIds = await _getKidIds(parentId);
    if (kidIds.isEmpty) {
      return [];
    }

    var query = _supabaseClient
        .from('reward_redemptions')
        .select(
          '''
          id,
          kid_id,
          reward_id,
          points_cost,
          redeemed_at,
          created_at,
          kids(name),
          rewards(name)
          ''',
        );

    if (kidIds.length == 1) {
      query = query.eq('kid_id', kidIds.first);
    } else {
      query = query.inFilter('kid_id', kidIds);
    }

    if (startDate != null) {
      query = query.gte('redeemed_at', startDate.toIso8601String());
    }
    if (endDate != null) {
      query = query.lte('redeemed_at', endDate.toIso8601String());
    }

    final response = await query.order('redeemed_at', ascending: false);
    return response
        .map((json) => RewardRedemption.fromJson(_enrichRedemptionJson(json)))
        .toList();
  }

  @override
  Future<List<RewardRedemption>> getRedemptionsByKid({
    required String kidId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    log.info('getRedemptionsByKid');
    var query = _supabaseClient
        .from('reward_redemptions')
        .select(
          '''
          id,
          kid_id,
          reward_id,
          points_cost,
          redeemed_at,
          created_at,
          kids(name),
          rewards(name)
          ''',
        )
        .eq('kid_id', kidId);

    if (startDate != null) {
      query = query.gte('redeemed_at', startDate.toIso8601String());
    }
    if (endDate != null) {
      query = query.lte('redeemed_at', endDate.toIso8601String());
    }

    final response = await query.order('redeemed_at', ascending: false);
    return response
        .map((json) => RewardRedemption.fromJson(_enrichRedemptionJson(json)))
        .toList();
  }

  @override
  Future<List<RewardRedemption>> getRedemptionsByReward({
    required String rewardId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    log.info('getRedemptionsByReward');
    var query = _supabaseClient
        .from('reward_redemptions')
        .select(
          '''
          id,
          kid_id,
          reward_id,
          points_cost,
          redeemed_at,
          created_at,
          kids(name),
          rewards(name)
          ''',
        )
        .eq('reward_id', rewardId);

    if (startDate != null) {
      query = query.gte('redeemed_at', startDate.toIso8601String());
    }
    if (endDate != null) {
      query = query.lte('redeemed_at', endDate.toIso8601String());
    }

    final response = await query.order('redeemed_at', ascending: false);
    return response
        .map((json) => RewardRedemption.fromJson(_enrichRedemptionJson(json)))
        .toList();
  }

  Future<List<String>> _getKidIds(String parentId) async {
    final response = await _supabaseClient
        .from('kids')
        .select('id')
        .eq('parent_id', parentId);
    return (response as List).map((e) => e['id'] as String).toList();
  }

  Map<String, dynamic> _enrichRedemptionJson(Map<String, dynamic> json) {
    final enriched = Map<String, dynamic>.from(json);
    if (json['kids'] != null && json['kids'] is Map) {
      enriched['kid_name'] = (json['kids'] as Map)['name'];
    }
    if (json['rewards'] != null && json['rewards'] is Map) {
      enriched['reward_name'] = (json['rewards'] as Map)['name'];
    }
    return enriched;
  }
}
