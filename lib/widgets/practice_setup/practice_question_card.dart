import 'package:flutter/material.dart';

class PracticeQuestionCard extends StatelessWidget {
  final Widget child;

  const PracticeQuestionCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
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
                  Icons.quiz_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),

              const SizedBox(width: 18),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(
                      "Number of Questions",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF173B7A),
                      ),
                    ),

                    SizedBox(height: 2),

                    Text(
                      "Choose how many questions to answer",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF74829C),
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),

          const SizedBox(height: 22),

          child,

        ],
      ),
    );
  }
}