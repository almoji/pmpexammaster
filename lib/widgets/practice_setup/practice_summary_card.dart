import 'package:flutter/material.dart';

class PracticeSummaryCard extends StatelessWidget {
  final int questions;
  final String time;
  final String goal;

  const PracticeSummaryCard({
    super.key,
    required this.questions,
    required this.time,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8FF),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFD8E9FF),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF63B4FF),
                      Color(0xFF2D86FF),
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.analytics_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),

              const SizedBox(width: 16),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Your Session",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF173B7A),
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      "Review before starting",
                      style: TextStyle(
                        color: Color(0xFF74829C),
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),

          const SizedBox(height: 28),

          Row(
            children: [

              Expanded(
                child: _Metric(
                  value: "$questions",
                  label: "Questions",
                ),
              ),

              Expanded(
                child: _Metric(
                  value: time,
                  label: "Time",
                ),
              ),

              Expanded(
                child: _Metric(
                  value: goal,
                  label: "Goal",
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {

  final String value;
  final String label;

  const _Metric({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D86FF),
          ),
        ),

        const SizedBox(height: 6),

        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF74829C),
          ),
        ),

      ],
    );
  }
}