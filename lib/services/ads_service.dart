import '../config/ads_config.dart';
import 'admob_service.dart';
import 'premium_service.dart';

class AdsService {
  AdsService._();

  static int _adsShownThisSession = 0;

  static DateTime? _lastInterstitialShown;

  static bool get shouldShowBanner {
    return PremiumService.isFree;
  }

  static bool get shouldShowInterstitial {
    return PremiumService.isFree;
  }

  static bool get shouldShowRewarded {
    return PremiumService.isFree;
  }

  static bool get canShowInterstitial {
    if (!shouldShowInterstitial) {
      return false;
    }

    if (_adsShownThisSession >=
        AdsConfig.maxInterstitialsPerSession) {
      return false;
    }

    if (_lastInterstitialShown != null &&
        DateTime.now().difference(_lastInterstitialShown!) <
            AdsConfig.minInterstitialInterval) {
      return false;
    }

    return true;
  }

  static Future<void> showInterstitial() async {
    if (!canShowInterstitial) {
      return;
    }

    await AdMobService.showInterstitial();

    _adsShownThisSession++;
    _lastInterstitialShown = DateTime.now();
  }

  static void resetSession() {
    _adsShownThisSession = 0;
    _lastInterstitialShown = null;
  }

  static Future<void> onQuestionAnswered({
    required int currentQuestion,
  }) async {
    if (currentQuestion %
        AdsConfig.questionsBetweenInterstitials !=
        0) {
      return;
    }

    await showInterstitial();
  }

  static Future<void> onExamFinished() async {
    if (!canShowInterstitial) {
      return;
    }

    await showInterstitial();
  }
}