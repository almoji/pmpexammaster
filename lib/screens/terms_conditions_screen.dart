import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: AppBar(
        title: const Text(
          "Terms & Conditions",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF173B7A),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Banner superior de marca PMP
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF173B7A),
                    Color(0xFF1A4590),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.gavel_rounded,
                      size: 38,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "PMP Exam Master",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Effective Date: August 2026",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),

            // Contenido principal en tarjetas
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: const [
                    _TermSectionTile(
                      number: "1",
                      title: "Acceptance of Terms",
                      icon: Icons.check_circle_outline_rounded,
                      content:
                      "By downloading, installing or using PMP Exam Master, you agree to these Terms & Conditions. If you do not agree with any part of these terms, please discontinue the use of the application.",
                    ),
                    _TermSectionTile(
                      number: "2",
                      title: "Educational Purpose",
                      icon: Icons.school_outlined,
                      content:
                      "PMP Exam Master is designed solely as an educational tool to help users prepare for the PMP® certification exam. The application provides practice questions, mock exams, statistics and study tools. It does not guarantee success in any certification examination.",
                    ),

                    // Sección 3 destacada por su importancia legal
                    _HighlightedDisclaimerTile(
                      number: "3",
                      title: "Independent Application",
                      content:
                      "PMP® is a registered trademark of the Project Management Institute (PMI). PMP Exam Master is an independent educational application and is not affiliated with, endorsed by, sponsored by or associated with PMI.",
                    ),

                    _TermSectionTile(
                      number: "4",
                      title: "User Responsibilities",
                      icon: Icons.verified_user_outlined,
                      content:
                      "Users agree to use the application responsibly and lawfully. You may not copy, redistribute, reverse engineer, reproduce or commercially exploit any part of the application or its content.",
                    ),
                    _TermSectionTile(
                      number: "5",
                      title: "Premium Subscription",
                      icon: Icons.workspace_premium_outlined,
                      content:
                      "Some features are available only through a Premium subscription, including unlimited mock exams, access to the full question bank, AI-powered study tools and an ad-free experience. All subscriptions are managed through Google Play and are subject to Google's billing policies.",
                    ),
                    _TermSectionTile(
                      number: "6",
                      title: "Free Version",
                      icon: Icons.card_giftcard_rounded,
                      content:
                      "The free version provides limited access to study content and may display advertisements. Features available in the free version may change in future releases.",
                    ),
                    _TermSectionTile(
                      number: "7",
                      title: "Intellectual Property",
                      icon: Icons.copyright_rounded,
                      content:
                      "All questions, explanations, graphics, logos, source code, application design and other content are the intellectual property of PMP Exam Master and are protected by applicable copyright laws.",
                    ),
                    _TermSectionTile(
                      number: "8",
                      title: "Disclaimer",
                      icon: Icons.warning_amber_rounded,
                      content:
                      "The application is provided 'as is' without warranties of any kind. Although we strive to provide accurate and up-to-date educational content, we cannot guarantee that all information is free of errors or omissions.",
                    ),
                    _TermSectionTile(
                      number: "9",
                      title: "Limitation of Liability",
                      icon: Icons.shield_outlined,
                      content:
                      "To the maximum extent permitted by law, PMP Exam Master shall not be liable for any direct or indirect damages arising from the use or inability to use the application, including examination outcomes or loss of data.",
                    ),
                    _TermSectionTile(
                      number: "10",
                      title: "Changes to these Terms",
                      icon: Icons.update_rounded,
                      content:
                      "We reserve the right to update these Terms & Conditions at any time. Updated versions will become effective when published within the application.",
                    ),

                    _ContactTile(
                      number: "11",
                      title: "Contact",
                      email: "albertomoyajimenez@hotmail.com",
                    ),

                    _TermSectionTile(
                      number: "12",
                      title: "Governing Law",
                      icon: Icons.account_balance_outlined,
                      isLast: true,
                      content:
                      "These Terms & Conditions shall be governed by the applicable laws governing the operation of this application.",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

/// Widget reutilizable para cada sección con viñeta numerada e icono
class _TermSectionTile extends StatelessWidget {
  final String number;
  final String title;
  final IconData icon;
  final String content;
  final bool isLast;

  const _TermSectionTile({
    required this.number,
    required this.title,
    required this.icon,
    required this.content,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF4FF),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                "#$number",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2563EB),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Icon(icon, size: 20, color: const Color(0xFF173B7A)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF173B7A),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            height: 1.5,
            color: Color(0xFF4F5D75),
          ),
        ),
        if (!isLast) ...[
          const SizedBox(height: 18),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          const SizedBox(height: 18),
        ],
      ],
    );
  }
}

/// Tarjeta destacada para descargos de responsabilidad legal (PMI / PMP)
class _HighlightedDisclaimerTile extends StatelessWidget {
  final String number;
  final String title;
  final String content;

  const _HighlightedDisclaimerTile({
    required this.number,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFBEB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFFDE68A)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  color: Color(0xFFD97706),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  "$number. $title",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF92400E),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.5,
                color: Color(0xFF78350F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tarjeta limpia para los datos de contacto
class _ContactTile extends StatelessWidget {
  final String number;
  final String title;
  final String email;

  const _ContactTile({
    required this.number,
    required this.title,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF4FF),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                "#$number",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2563EB),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.mail_outline_rounded, size: 20, color: Color(0xFF173B7A)),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF173B7A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          "For questions regarding these Terms & Conditions, please contact:",
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF4F5D75),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.email, size: 18, color: Color(0xFF2563EB)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  email,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Divider(height: 1, color: Color(0xFFE2E8F0)),
        const SizedBox(height: 18),
      ],
    );
  }
}