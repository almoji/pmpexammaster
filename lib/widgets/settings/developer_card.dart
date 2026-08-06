import 'package:flutter/material.dart';

import '../../services/premium_service.dart';
import '../../services/ads_service.dart';


class DeveloperCard extends StatefulWidget {
  final VoidCallback onModeChanged;

  const DeveloperCard({
    super.key,
    required this.onModeChanged,
  });

  @override
  State<DeveloperCard> createState() => _DeveloperCardState();
}

class _DeveloperCardState extends State<DeveloperCard> {
  Future<void> _toggleMode() async {
    await PremiumService.setPremium(
      !PremiumService.isPremium,
    );

    widget.onModeChanged();

    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FC),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Developer Mode",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF173B7A),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [

              Icon(
                PremiumService.isPremium
                    ? Icons.workspace_premium
                    : Icons.ads_click,
                color: PremiumService.isPremium
                    ? Colors.amber
                    : Colors.blue,
              ),

              const SizedBox(width: 10),

              Text(
                PremiumService.isPremium
                    ? "Current Mode: PREMIUM"
                    : "Current Mode: FREE",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

            ],
          ),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () async {
                await AdsService.showInterstitial();
              },
              child: const Text("🧪 Test Interstitial"),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _toggleMode,
              child: Text(
                PremiumService.isPremium
                    ? "Switch to FREE"
                    : "Switch to PREMIUM",
              ),
            ),
          ),
        ],
      ),
    );
  }
}