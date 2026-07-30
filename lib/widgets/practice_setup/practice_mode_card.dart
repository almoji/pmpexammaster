import 'package:flutter/material.dart';
import '../app_dropdown.dart';

class PracticeModeCard extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const PracticeModeCard({
    super.key,
    required this.value,
    required this.onChanged,
  });

  static const List<String> modes = [
    "Random Questions",
    "By Domain",
    "By Difficulty",
    "By Question Type",
    "Incorrect Questions",
    "Favorite Questions",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 24,
            spreadRadius: -6,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF63B4FF),
                      Color(0xFF2D86FF),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.tune_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),

              const SizedBox(width: 16),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Practice Mode",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF173B7A),
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      "Select how you want to practice",
                      style: TextStyle(
                        color: Color(0xFF74829C),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          AppDropdown<String>(
            value: value,

            onChanged: onChanged,

            entries: modes
                .map(
                  (e) => DropdownMenuEntry<String>(
                value: e,
                label: e,
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }
}