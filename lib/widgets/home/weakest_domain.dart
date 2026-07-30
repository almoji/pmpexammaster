import 'package:flutter/material.dart';

class WeakestDomain extends StatelessWidget {
  final String domain;
  final double score;
  final VoidCallback onPractice;

  const WeakestDomain({
    super.key,
    required this.domain,
    required this.score,
    required this.onPractice,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (score / 100).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 30,
            spreadRadius: -8,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFFC55A),
                      Color(0xFFF39A1E),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.white,
                  size: 34,
                ),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Focus Area",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF173B7A),
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      domain,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF6F7D97),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF4E2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  "LOW",
                  style: TextStyle(
                    color: Color(0xFFF39A1E),
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: .7,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 26),

          const Text(
            "Your score in this PMP domain is below your average. Review the concepts and practice targeted questions to improve your exam readiness.",
            style: TextStyle(
              color: Color(0xFF6F7D97),
              fontSize: 14,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 22),

          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              height: 12,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: const Color(0xFFE9EFF8),
                color: const Color(0xFFF39A1E),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Text(
                "${score.round()}%",
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF39A1E),
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Text(
                  "Needs Improvement",
                  style: TextStyle(
                    color: Color(0xFFF39A1E),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),

              Text(
                "${score.round()}/100",
                style: const TextStyle(
                  color: Color(0xFF8A94A6),
                  fontSize: 13,
                ),
              ),
            ],
          ),

          const SizedBox(height: 26),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: onPractice,
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text(
                "Practice this Domain",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFF2D86FF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}