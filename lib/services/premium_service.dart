import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class PremiumService {
  PremiumService._();

  static const _premiumKey = 'is_premium';

  static bool _isPremium = false;

  static final ValueNotifier<bool> premiumNotifier =
  ValueNotifier(false);

  static bool get isPremium => _isPremium;

  static bool get isFree => !_isPremium;

  static Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();

    _isPremium = prefs.getBool(_premiumKey) ?? false;
    premiumNotifier.value = _isPremium;
  }

  static Future<void> setPremium(bool value) async {
    _isPremium = value;
    premiumNotifier.value = value;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_premiumKey, value);
  }

  /// Called by BillingService whenever Google Play confirms
  /// the Premium entitlement.
  static Future<void> refreshPremium(bool value) async {
    await setPremium(value);
  }

  static Future<void> unlockPremium() async {
    await refreshPremium(true);
  }

  static Future<void> lockPremium() async {
    await refreshPremium(false);
  }
}