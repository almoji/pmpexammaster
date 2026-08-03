import 'package:flutter/material.dart';

import '../../services/premium_service.dart';
import 'premium_upgrade_dialog.dart';

class FreePlanCard extends StatelessWidget {

  final String message;

  const FreePlanCard({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {

    if (PremiumService.isPremium) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F9FF),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFD7E8FF),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Row(
            children: [

              Icon(
                Icons.workspace_premium_rounded,
                color: Color(0xFFFFB800),
              ),

              SizedBox(width: 10),

              Text(
                "Free Plan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: Color(0xFF173B7A),
                ),
              ),

            ],
          ),

          const SizedBox(height: 14),

          Text(
            message,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Color(0xFF4F5D75),
            ),
          ),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {

                showDialog(
                  context: context,
                  builder: (_) => const PremiumUpgradeDialog(
                    title: "Unlock the Full Question Bank",
                    message:
                    "Upgrade to Premium to access all 10,000+ PMP questions and all premium features.",
                  ),
                );

              },
              child: const Text("Upgrade to Premium"),
            ),
          ),

        ],
      ),
    );
  }
}