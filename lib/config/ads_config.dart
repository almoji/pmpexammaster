class AdsConfig {
  AdsConfig._();

  /// Número de preguntas entre anuncios
  static const int questionsBetweenInterstitials = 10;

  /// Máximo de interstitials por sesión
  static const int maxInterstitialsPerSession = 10;

  /// Tiempo mínimo entre anuncios
  static const Duration minInterstitialInterval =
  Duration(minutes: 2);
}