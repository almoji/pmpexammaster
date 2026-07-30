import 'package:flutter/material.dart';

class BottomBanner extends StatelessWidget {
  const BottomBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4C97FF),
            Color(0xFF1E78FF),
          ],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Keep Learning!",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  "You're making excellent progress.\nComplete one more session today!",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 18),

          Container(
            width: 74,
            height: 74,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.school_rounded,
              size: 42,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}