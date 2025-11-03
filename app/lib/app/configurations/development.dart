import 'package:logging/logging.dart' as logging;

import '../../inside/i18n/translations.g.dart';
import '../../outside/client_providers/supabase/client_provider_configuration.dart';
import '../../outside/effect_providers/mixpanel/effect_provider_configuration.dart';
import '../../outside/theme/theme.dart';
import '../runner.dart';
import 'configuration.dart';

void main() {
  final configuration = AppConfiguration(
    appLocale: AppLocale.esCo,
    logLevel: logging.Level.ALL,
    theme: OutsideThemes.lightTheme,
    deepLinkBaseUri:
        'com.daniel.villamizar.habit-heroes.dev.deep://deeplink-callback',
    clientProvidersConfigurations: ClientProvidersConfigurations(
      sentry: null,
      supabase: const Supabase_ClientProvider_Configuration(
        url: 'http://192.168.40.13:54321',
        anonKey: '''sb_publishable_ACJWlzQHlZjBrEguHvfOxg_3BJgxAaH''',
      ),
    ),
    effectProvidersConfigurations: EffectProvidersConfigurations(
      mixpanel: const Mixpanel_EffectProvider_Configuration(
        sendEvents: false,
        token: null,
        environment: null,
      ),
    ),
  );

  appRunner(configuration: configuration);
}
