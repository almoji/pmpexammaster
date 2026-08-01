import 'premium_service.dart';

class AdsService {
  AdsService._();

  /// Returns true when banner ads should be displayed.
  static bool get shouldShowBanner {
    return PremiumService.isFree;
  }

  /// Returns true when interstitial ads should be displayed.
  static bool get shouldShowInterstitial {
    return PremiumService.isFree;
  }

  /// Returns true when rewarded ads should be displayed.
  static bool get shouldShowRewarded {
    return PremiumService.isFree;
  }
}