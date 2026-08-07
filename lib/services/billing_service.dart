import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'premium_service.dart';

class BillingService {
  BillingService._();

  static final InAppPurchase instance =
      InAppPurchase.instance;

  static const String premiumProductId =
      'pmp_exam_master_premium';

  static const Set<String> productIds = {
    premiumProductId,
  };

  static bool _initialized = false;
  static StreamSubscription<List<PurchaseDetails>>?
  _purchaseSubscription;

  static List<ProductDetails> _products = [];

  static List<ProductDetails> get products => _products;

  static ProductDetails? get premiumProduct {
    try {
      return _products.firstWhere(
            (p) => p.id == premiumProductId,
      );
    } catch (_) {
      return null;
    }
  }

  static Future<bool> isAvailable() async {
    return await instance.isAvailable();
  }

  static Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    _initialized = true;

    final available = await isAvailable();

    if (!available) {
      debugPrint('❌ Google Play Billing unavailable');
      return;
    }

    _products = await loadProducts();

    _startPurchaseListener();

    // NUEVO
    debugPrint('🔄 Restoring previous purchases...');
    await instance.restorePurchases();

    debugPrint(
      '✅ Billing initialized (${_products.length} products)',
    );
  }

  static Future<List<ProductDetails>> loadProducts() async {
    final response = await instance.queryProductDetails(
      productIds,
    );

    if (response.error != null) {
      debugPrint(
        '❌ Billing error: ${response.error}',
      );
    }

    if (response.notFoundIDs.isNotEmpty) {
      debugPrint(
        '⚠️ Products not found: ${response.notFoundIDs}',
      );
    }

    debugPrint(
      '✅ Products found: ${response.productDetails.length}',
    );

    return response.productDetails;
  }

  static Future<bool> buyPremium() async {
    final product = premiumProduct;

    if (product == null) {
      debugPrint('❌ Premium product not found');
      return false;
    }

    final purchaseParam = PurchaseParam(
      productDetails: product,
    );

    return instance.buyNonConsumable(
      purchaseParam: purchaseParam,
    );
  }

  static void _startPurchaseListener() {
    _purchaseSubscription ??=
        instance.purchaseStream.listen(
              (purchases) async {
            for (final purchase in purchases) {

              if (purchase.status == PurchaseStatus.purchased ||
                  purchase.status == PurchaseStatus.restored) {

                debugPrint(
                  '✅ Purchase received: ${purchase.productID}',
                );

                if (purchase.productID == premiumProductId) {
                  await PremiumService.refreshPremium(true);

                  debugPrint('⭐ Premium unlocked');
                }

                if (purchase.pendingCompletePurchase) {
                  await instance.completePurchase(
                    purchase,
                  );
                }
              }

              if (purchase.status == PurchaseStatus.error) {
                debugPrint(
                  '❌ Purchase error: ${purchase.error}',
                );
              }
            }
          },
          onDone: () {
            _purchaseSubscription?.cancel();
            _purchaseSubscription = null;
          },
          onError: (error) {
            debugPrint(
              '❌ Purchase stream error: $error',
            );
          },
        );
  }
  static Future<void> restorePurchases() async {
    debugPrint('🔄 Restoring purchases...');
    await instance.restorePurchases();
  }


}