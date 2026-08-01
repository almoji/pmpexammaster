import 'premium_service.dart';

class FeatureGate {
  FeatureGate._();

  /// Ads
  static bool get bannerAds =>
      PremiumService.isFree;

  /// Mock Exams
  static bool get unlimitedMockExams =>
      PremiumService.isPremium;

  /// Daily Coach
  static bool get advancedDailyCoach =>
      PremiumService.isPremium;

  /// Dashboard
  static bool get advancedAnalytics =>
      PremiumService.isPremium;

  /// Flashcards (future)
  static bool get flashcards =>
      PremiumService.isPremium;

  /// AI Coach (future)
  static bool get aiCoach =>
      PremiumService.isPremium;
}