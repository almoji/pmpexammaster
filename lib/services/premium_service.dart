import 'package:shared_preferences/shared_preferences.dart';

class PremiumService {
  PremiumService._();

  static const _premiumKey = 'is_premium';

  static bool _isPremium = false;

  static bool get isPremium => _isPremium;

  static bool get isFree => !_isPremium;

  static Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();

    _isPremium = prefs.getBool(_premiumKey) ?? false;
  }

  static Future<void> setPremium(bool value) async {
    _isPremium = value;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_premiumKey, value);
  }
  static Future<void> unlockPremium() async {
    await setPremium(true);
  }

  static Future<void> lockPremium() async {
    await setPremium(false);
  }

}