import 'package:flutter/material.dart';

import '../../services/premium_service.dart';
import '../../services/purchase_service.dart';

class PremiumCard extends StatefulWidget {
  const PremiumCard({super.key});

  @override
  State<PremiumCard> createState() => _PremiumCardState();
}

class _PremiumCardState extends State<PremiumCard> {

  Future<void> _upgrade() async {

    final success =
    await PurchaseService.purchasePremium();

    if (!mounted) return;

    if (success) {
      setState(() {});
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? "Premium activated (Demo)"
              : "Purchase failed",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    if (PremiumService.isPremium) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF18B76A),
              Color(0xFF35D07F),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                Icon(
                  Icons.verified_rounded,
                  color: Colors.white,
                  size: 34,
                ),

                SizedBox(width: 12),

                Text(
                  "Premium Activated",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

            SizedBox(height: 16),

            Text(
              "Thank you for supporting PMP Exam Master.\nAll Premium features are unlocked.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.5,
              ),
            ),

          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2D86FF),
            Color(0xFF5A9BFF),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Row(
            children: [

              Icon(
                Icons.workspace_premium_rounded,
                color: Colors.white,
                size: 34,
              ),

              SizedBox(width: 12),

              Text(
                "Go Premium",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
          ),

          const SizedBox(height: 16),

          const Text(
            "Unlock unlimited mock exams, AI Coach, flashcards and advanced analytics.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 22),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _upgrade,
              child: const Text("Upgrade Now"),
            ),
          ),

        ],
      ),
    );
  }
}