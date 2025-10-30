import 'base.dart';
import 'sentry/client_provider.dart';
import 'shared_preferences/client_provider.dart';
import 'supabase/client_provider.dart';

/// When adding a new client provider, be sure to add it to:
/// - [getList]
class ClientProviders_All {
  ClientProviders_All({
    required this.sentryClientProvider,
    required this.sharedPreferencesClientProvider,
    required this.supabaseClientProvider,
  });

  final Sentry_ClientProvider sentryClientProvider;
  final SharedPreferences_ClientProvider sharedPreferencesClientProvider;
  final Supabase_ClientProvider supabaseClientProvider;

  List<ClientProvider_Base> getList() => [
    sentryClientProvider,
    sharedPreferencesClientProvider,
    supabaseClientProvider,
  ];

  Future<void> initialize() async {
    await Future.forEach(getList(), (r) async {
      r.log.fine('init');
      await r.init();
    });
  }
}
