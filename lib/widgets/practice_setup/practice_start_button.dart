import 'package:flutter/material.dart';

class PracticeStartButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PracticeStartButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF63B4FF),
              Color(0xFF2D86FF),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2D86FF).withValues(alpha: 0.30),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(
                Icons.play_arrow_rounded,
                size: 28,
                color: Colors.white,
              ),

              SizedBox(width: 10),

              Text(
                "START PRACTICE",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: .4,
                  color: Colors.white,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}