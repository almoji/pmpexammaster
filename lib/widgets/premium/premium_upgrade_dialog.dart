import 'package:flutter/material.dart';

import '../../services/billing_service.dart';

class PremiumUpgradeDialog extends StatelessWidget {

  final String title;
  final String message;

  const PremiumUpgradeDialog({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            const Icon(
              Icons.workspace_premium_rounded,
              color: Color(0xFFFFB800),
              size: 60,
            ),

            const SizedBox(height: 18),

            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            Text(
              message,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            const _Feature(Icons.all_inclusive, "Unlimited Mock Exams"),
            const _Feature(Icons.quiz_rounded, "10,000+ PMP Questions"),
            const _Feature(Icons.psychology_alt_rounded, "AI Coach"),
            const _Feature(Icons.block_rounded, "Ad-Free Experience"),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {

                  final success =
                  await BillingService.buyPremium();

                  if (!context.mounted) return;

                  if (success) {
                    Navigator.pop(context, true);
                  }

                },
                child: Text(
                  BillingService.premiumProduct == null
                      ? "Upgrade to Premium"
                      : "Upgrade to Premium • ${BillingService.premiumProduct!.price}",
                ),
              ),
            ),

            const SizedBox(height: 10),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Not now"),
            ),

          ],
        ),
      ),
    );
  }
}

class _Feature extends StatelessWidget {

  final IconData icon;
  final String text;

  const _Feature(this.icon, this.text);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [

          Icon(
            icon,
            color: const Color(0xFF2D86FF),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(text),
          ),

        ],
      ),
    );
  }
}