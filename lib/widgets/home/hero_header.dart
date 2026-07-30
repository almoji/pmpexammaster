import 'package:flutter/material.dart';
import 'painters/hero_background.dart';
import 'hero_wave_clipper.dart';

class HeroHeader extends StatelessWidget {
  const HeroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HeroWaveClipper(),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0D47A1),
              Color(0xFF1565C0),
              Color(0xFF42A5F5),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: HeroBackgroundPainter(),
              ),
            ),

            Positioned(
              top: -90,
              right: -50,
              child: Container(
                width: 190,
                height: 190,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.03),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  12,
                  24,
                  38,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Image.asset(
                      "assets/icon/logo_horizontal.png",
                      width: MediaQuery.of(context).size.width * .86,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Prepare • Practice • Pass",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: .6,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Master the PMP® Exam with confidence",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}