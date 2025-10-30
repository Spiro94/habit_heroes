import 'package:shared_preferences/shared_preferences.dart';

import '../base.dart';

class SharedPreferences_ClientProvider extends ClientProvider_Base {
  SharedPreferences? _prefs;

  SharedPreferences get prefs {
    if (_prefs == null) {
      throw StateError(
        'SharedPreferences not initialized. Call init() first.',
      );
    }
    return _prefs!;
  }

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
}
