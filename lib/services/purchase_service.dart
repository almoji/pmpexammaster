import 'premium_service.dart';

class PurchaseService {
  PurchaseService._();

  /// Simulates upgrading to Premium.
  static Future<bool> purchasePremium() async {
    await PremiumService.setPremium(true);
    return true;
  }

  /// Simulates restoring purchases.
  static Future<bool> restorePurchases() async {
    return PremiumService.isPremium;
  }
}