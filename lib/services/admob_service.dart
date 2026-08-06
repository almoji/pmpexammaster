import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  AdMobService._();

  static InterstitialAd? _interstitialAd;

  static bool get isInterstitialReady =>
      _interstitialAd != null;

  static Future<void> initialize() async {
    await MobileAds.instance.initialize();

    loadInterstitial();
  }

  static void loadInterstitial() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;

          debugPrint('✅ Interstitial loaded');
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;

          debugPrint('❌ Interstitial failed: $error');
        },
      ),
    );
  }

  static Future<void> showInterstitial() async {
    if (!isInterstitialReady) {
      debugPrint('⚠️ Interstitial not ready');
      return;
    }

    _interstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            debugPrint('✅ Interstitial dismissed');

            ad.dispose();

            _interstitialAd = null;

            loadInterstitial();
          },
          onAdFailedToShowFullScreenContent: (ad, error) {
            debugPrint('❌ Failed to show: $error');

            ad.dispose();

            _interstitialAd = null;

            loadInterstitial();
          },
        );

    await _interstitialAd!.show();
  }

  static BannerAd createBannerAd({
    required BannerAdListener listener,
  }) {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: listener,
    );
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }

    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    }

    throw UnsupportedError('Unsupported platform');
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }

    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    }

    throw UnsupportedError('Unsupported platform');
  }


}