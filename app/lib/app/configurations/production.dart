import 'package:logging/logging.dart' as logging;

import '../../inside/i18n/translations.g.dart';
import '../../outside/client_providers/supabase/client_provider_configuration.dart';
import '../../outside/effect_providers/mixpanel/effect_provider_configuration.dart';
import '../../outside/theme/theme.dart';
import '../runner.dart';
import 'configuration.dart';

// TODO: update CHANGE_ME lines

void main() {
  final configuration = AppConfiguration(
    appLocale: AppLocale.esCo,
    logLevel: logging.Level.INFO,
    theme: OutsideThemes.lightTheme,
    deepLinkBaseUri:
        'com.daniel.villamizar.habit_heroes.deep://deeplink-callback',
    clientProvidersConfigurations: ClientProvidersConfigurations(
      sentry: null,
      supabase: const Supabase_ClientProvider_Configuration(
        url: 'https://fpfpxsfqphascipoibbj.supabase.co',
        anonKey: '''sb_publishable_4a0xrMFx7ZnwQ2HYOi6MkQ_XhsCwK98''',
      ),
    ),
    effectProvidersConfigurations: EffectProvidersConfigurations(
      mixpanel: const Mixpanel_EffectProvider_Configuration(
        sendEvents: false,
        token: 'CHANGE_ME',
        environment: 'CHANGE_ME',
      ),
    ),
  );

  appRunner(configuration: configuration);
}
