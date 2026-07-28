import 'package:flutter/widgets.dart';

class AppSpacing {
  AppSpacing._();

  //==========================================================
  // SPACING VALUES
  //==========================================================

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  //==========================================================
  // VERTICAL SPACE
  //==========================================================

  static const Widget vSpaceXs = SizedBox(height: xs);
  static const Widget vSpaceSm = SizedBox(height: sm);
  static const Widget vSpaceMd = SizedBox(height: md);
  static const Widget vSpaceLg = SizedBox(height: lg);
  static const Widget vSpaceXl = SizedBox(height: xl);

  //==========================================================
  // HORIZONTAL SPACE
  //==========================================================

  static const Widget hSpaceXs = SizedBox(width: xs);
  static const Widget hSpaceSm = SizedBox(width: sm);
  static const Widget hSpaceMd = SizedBox(width: md);
  static const Widget hSpaceLg = SizedBox(width: lg);
  static const Widget hSpaceXl = SizedBox(width: xl);
}