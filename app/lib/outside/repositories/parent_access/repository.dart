import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../client_providers/shared_preferences/client_provider.dart';
import '../base.dart';

class ParentAccess_Repository extends Repository_Base {
  ParentAccess_Repository({
    required SharedPreferences_ClientProvider sharedPreferencesClientProvider,
  }) : _sharedPreferencesClientProvider = sharedPreferencesClientProvider;

  final SharedPreferences_ClientProvider _sharedPreferencesClientProvider;

  static const String _pinKey = 'parent_access_pin';

  @override
  Future<void> init() async {}

  String _hashPin(String pin) {
    final bytes = utf8.encode(pin);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Checks if a PIN exists in storage
  Future<bool> hasPinConfigured() async {
    final prefs = _sharedPreferencesClientProvider.prefs;
    return prefs.containsKey(_pinKey);
  }

  /// Creates and stores a new PIN
  /// Returns true if successful, throws exception otherwise
  Future<void> createPin({required String pin}) async {
    log.info('createPin');

    if (pin.length != 4) {
      throw ArgumentError('PIN must be exactly 4 digits');
    }

    final hashedPin = _hashPin(pin);
    final prefs = _sharedPreferencesClientProvider.prefs;
    final success = await prefs.setString(_pinKey, hashedPin);

    if (!success) {
      throw Exception('Failed to save PIN');
    }

    log.fine('PIN created successfully');
  }

  /// Verifies if the provided PIN matches the stored PIN
  /// Returns true if PIN matches, false otherwise
  Future<bool> verifyPin({required String pin}) async {
    log.info('verifyPin');

    final prefs = _sharedPreferencesClientProvider.prefs;
    final storedHashedPin = prefs.getString(_pinKey);

    if (storedHashedPin == null) {
      throw StateError('No PIN configured');
    }

    final hashedInputPin = _hashPin(pin);
    final isValid = hashedInputPin == storedHashedPin;

    log.fine('PIN verification: ${isValid ? 'success' : 'failed'}');

    return isValid;
  }

  /// Updates the stored PIN after verifying the current PIN
  /// Throws exception if current PIN is invalid or update fails
  Future<void> updatePin({
    required String currentPin,
    required String newPin,
  }) async {
    log.info('updatePin');

    if (newPin.length != 4) {
      throw ArgumentError('PIN must be exactly 4 digits');
    }

    final isCurrentPinValid = await verifyPin(pin: currentPin);
    if (!isCurrentPinValid) {
      throw ArgumentError('Current PIN is invalid');
    }

    final hashedNewPin = _hashPin(newPin);
    final prefs = _sharedPreferencesClientProvider.prefs;
    final success = await prefs.setString(_pinKey, hashedNewPin);

    if (!success) {
      throw Exception('Failed to update PIN');
    }

    log.fine('PIN updated successfully');
  }

  /// Removes the stored PIN (for testing or reset purposes)
  Future<void> clearPin() async {
    log.info('clearPin');
    final prefs = _sharedPreferencesClientProvider.prefs;
    await prefs.remove(_pinKey);
  }
}
