import 'package:flutter/material.dart';

class AppRadius {
  AppRadius._();

  //==========================================================
  // RADII
  //==========================================================

  static const Radius small = Radius.circular(8);
  static const Radius medium = Radius.circular(14);
  static const Radius large = Radius.circular(18);
  static const Radius extraLarge = Radius.circular(24);

  //==========================================================
  // BORDER RADIUS
  //==========================================================

  static const BorderRadius sm =
  BorderRadius.all(small);

  static const BorderRadius md =
  BorderRadius.all(medium);

  static const BorderRadius lg =
  BorderRadius.all(large);

  static const BorderRadius xl =
  BorderRadius.all(extraLarge);
}