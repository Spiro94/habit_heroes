import 'package:supabase_flutter/supabase_flutter.dart';

import '../../client_providers/supabase/client_provider.dart';
import '../base.dart';

class AccountDeletion_Repository extends Repository_Base {
  AccountDeletion_Repository({required this.supabaseClientProvider})
    : _supabaseClient = null;

  /// Convenience constructor for standalone contexts (e.g., web-only page)
  AccountDeletion_Repository.fromClient({
    required SupabaseClient supabaseClient,
  }) : supabaseClientProvider = null,
       _supabaseClient = supabaseClient;

  final Supabase_ClientProvider? supabaseClientProvider;
  final SupabaseClient? _supabaseClient;

  SupabaseClient get _client =>
      supabaseClientProvider?.client ?? _supabaseClient!;

  @override
  Future<void> init() async {
    log.fine('AccountDeletion Repository initialized');
  }

  /// Returns true when the request is created.
  /// Returns false when a request for the given email already exists.
  Future<bool> requestAccountDeletion(String email, {String? reason}) async {
    try {
      await _client.from('account_deletion_requests').insert({
        'email': email,
        if (reason != null) 'reason': reason,
        // if user is authenticated, link it
        if (_client.auth.currentUser != null)
          'user_id': _client.auth.currentUser!.id,
      });
      return true;
    } on PostgrestException catch (e) {
      // Unique violation on email -> already exists
      if (e.code == '23505' || e.message.toLowerCase().contains('duplicate')) {
        return false;
      }
      log.severe('Postgrest error creating deletion request: ${e.message}');
      rethrow;
    } catch (e) {
      log.severe('Unexpected error creating deletion request: $e');
      rethrow;
    }
  }

  /// Checks if the currently authenticated user already has a pending
  /// deletion request.
  Future<bool> hasPendingDeletionRequest() async {
    final user = _client.auth.currentUser;
    if (user == null) return false;
    try {
      final List<dynamic> rows = await _client
          .from('account_deletion_requests')
          .select('id')
          .eq('user_id', user.id)
          .limit(1);
      return rows.isNotEmpty;
    } on PostgrestException catch (e) {
      log.severe('Postgrest error checking deletion request: ${e.message}');
      rethrow;
    } catch (e) {
      log.severe('Unexpected error checking deletion request: $e');
      rethrow;
    }
  }
}
