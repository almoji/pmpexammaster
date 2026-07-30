import 'package:flutter/material.dart';

class HeroWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    final path = Path();

    path.lineTo(0, size.height - 18);

    path.quadraticBezierTo(
      size.width * .50,
      size.height + 18,
      size.width,
      size.height - 18,
    );

    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}