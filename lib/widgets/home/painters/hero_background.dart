import 'package:flutter/material.dart';

class HeroBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.025)
      ..strokeWidth = 1;

    // Grid
    const double spacing = 30;

    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        gridPaint,
      );
    }

    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final nodePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08);

    // Decorative project network

    final p1 = Offset(size.width * .15, size.height * .25);
    final p2 = Offset(size.width * .35, size.height * .18);
    final p3 = Offset(size.width * .58, size.height * .30);
    final p4 = Offset(size.width * .80, size.height * .20);

    canvas.drawLine(p1, p2, linePaint);
    canvas.drawLine(p2, p3, linePaint);
    canvas.drawLine(p3, p4, linePaint);

    canvas.drawCircle(p1, 4, nodePaint);
    canvas.drawCircle(p2, 4, nodePaint);
    canvas.drawCircle(p3, 4, nodePaint);
    canvas.drawCircle(p4, 4, nodePaint);

    // Timeline

    final timelineY = size.height * .72;

    canvas.drawLine(
      Offset(40, timelineY),
      Offset(size.width - 40, timelineY),
      linePaint,
    );

    for (int i = 0; i < 6; i++) {
      final x = 40 + ((size.width - 80) / 5) * i;

      canvas.drawCircle(
        Offset(x, timelineY),
        4,
        nodePaint,
      );
    }

    // Target

    canvas.drawCircle(
      Offset(size.width * .82, size.height * .78),
      22,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.05)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    canvas.drawCircle(
      Offset(size.width * .82, size.height * .78),
      10,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.08)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}