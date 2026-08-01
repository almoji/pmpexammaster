import 'package:flutter/material.dart';

import '../widgets/settings/premium_card.dart';
import 'privacy_policy_screen.dart';
import '../widgets/settings/developer_card.dart';
import '../widgets/ads/banner_ad_widget.dart';
import '../screens/terms_conditions_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFEAF4FF),
              Color(0xFFF6F9FE),
              Colors.white,
            ],
            stops: [
              0,
              .22,
              .45,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const PremiumCard(),

              const SizedBox(height: 24),

              _buildSettingTile(
                icon: Icons.star_rounded,
                color: const Color(0xFFFF9800),
                title: "Rate the App",
                subtitle: "Help us with a review on Google Play",
                onTap: () {},
              ),

              const SizedBox(height: 12),

              _buildSettingTile(
                icon: Icons.support_agent_rounded,
                color: const Color(0xFF2D86FF),
                title: "Contact Support",
                subtitle: "Questions, suggestions or feedback",
                onTap: () {},
              ),

              const SizedBox(height: 12),

              _buildSettingTile(

                icon: Icons.privacy_tip_rounded,

                color: const Color(0xFF18B76A),

                title: "Privacy Policy",

                subtitle: "Read how we protect your data",

                onTap: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) => const PrivacyPolicyScreen(),

                    ),

                  );

                },

              ),

              const SizedBox(height: 12),

              _buildSettingTile(
                icon: Icons.description_rounded,
                color: const Color(0xFF7A4DFF),
                title: "Terms & Conditions",
                subtitle: "Read the terms of use",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TermsConditionsScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              _buildSettingTile(
                icon: Icons.info_outline_rounded,
                color: const Color(0xFF74829C),
                title: "About",
                subtitle: "Application information",
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: "PMP Exam Master",
                    applicationVersion: "1.0.0",
                    applicationLegalese: "© 2026 Alberto Moya",
                    children: const [
                      SizedBox(height: 12),
                      Text(
                        "PMP Exam Master is designed to help professionals prepare for the PMP® certification through realistic mock exams, domain practice and performance analytics.",
                      ),
                    ],
                  );
                },
              ),



              const SizedBox(height: 28),

              const Text(
                "Version 1.0.0",
                style: TextStyle(
                  color: Color(0xFF74829C),
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 28),



              DeveloperCard(
                onModeChanged: () {
                  setState(() {});
                },
              ),

              const SizedBox(height: 24),

              const BannerAdWidget(),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: const Color(0xFFE7EEF8),
                  ),
                ),
                child: const Column(
                  children: [
                    Text(
                      "PMP Exam Master",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF173B7A),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Version 1.0.0",
                      style: TextStyle(
                        color: Color(0xFF74829C),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Built to help professionals prepare for the PMP® certification exam.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF74829C),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: const Color(0xFFE7EEF8),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF173B7A),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF74829C),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFFB7C2D3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}