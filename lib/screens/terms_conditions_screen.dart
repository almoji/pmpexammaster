import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const headingStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color(0xFF173B7A),
    );

    const bodyStyle = TextStyle(
      fontSize: 15,
      height: 1.6,
      color: Color(0xFF4F5D75),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Conditions"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [

              Text(
                "Terms & Conditions",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF173B7A),
                ),
              ),

              SizedBox(height: 8),

              Text(
                "Effective Date: August 2026",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              SizedBox(height: 30),

              Text("1. Acceptance of Terms", style: headingStyle),

              SizedBox(height: 10),

              Text(
                "By downloading, installing or using PMP Exam Master, you agree to these Terms & Conditions. If you do not agree with any part of these terms, please discontinue the use of the application.",
                style: bodyStyle,
              ),

              SizedBox(height: 28),

              Text("2. Educational Purpose", style: headingStyle),

              SizedBox(height: 10),

              Text(
                "PMP Exam Master is designed solely as an educational tool to help users prepare for the PMP® certification exam. The application provides practice questions, mock exams, statistics and study tools. It does not guarantee success in any certification examination.",
                style: bodyStyle,
              ),

              SizedBox(height: 28),

              Text("3. Independent Application", style: headingStyle),

              SizedBox(height: 10),

              Text(
                "PMP® is a registered trademark of the Project Management Institute (PMI). PMP Exam Master is an independent educational application and is not affiliated with, endorsed by, sponsored by or associated with PMI.",
                style: bodyStyle,
              ),

              SizedBox(height: 28),

              Text("4. User Responsibilities", style: headingStyle),

              SizedBox(height: 10),

              Text(
                "Users agree to use the application responsibly and lawfully. You may not copy, redistribute, reverse engineer, reproduce or commercially exploit any part of the application or its content.",
                style: bodyStyle,
              ),

              SizedBox(height: 28),

              Text("5. Premium Subscription", style: headingStyle),

              SizedBox(height: 10),

              Text(
                "Some features are available only through a Premium subscription, including unlimited mock exams, access to the full question bank, AI-powered study tools and an ad-free experience. All subscriptions are managed through Google Play and are subject to Google's billing policies.",
                style: bodyStyle,
              ),

              SizedBox(height: 28),

              Text("6. Free Version", style: headingStyle),

              SizedBox(height: 10),

              Text(
                "The free version provides limited access to study content and may display advertisements. Features available in the free version may change in future releases.",
                style: bodyStyle,
              ),

              SizedBox(height: 28),

              Text("7. Intellectual Property", style: headingStyle),

              SizedBox(height: 10),

              Text(
                "All questions, explanations, graphics, logos, source code, application design and other content are the intellectual property of PMP Exam Master and are protected by applicable copyright laws.",
                style: bodyStyle,
              ),

              SizedBox(height: 28),

              Text("8. Disclaimer", style: headingStyle),

              SizedBox(height: 10),

              Text(
                "The application is provided 'as is' without warranties of any kind. Although we strive to provide accurate and up-to-date educational content, we cannot guarantee that all information is free of errors or omissions.",
                style: bodyStyle,
              ),

              SizedBox(height: 28),

              Text("9. Limitation of Liability", style: headingStyle),

              SizedBox(height: 10),

              Text(
                "To the maximum extent permitted by law, PMP Exam Master shall not be liable for any direct or indirect damages arising from the use or inability to use the application, including examination outcomes or loss of data.",
                style: bodyStyle,
              ),

              SizedBox(height: 28),

              Text("10. Changes to these Terms", style: headingStyle),

              SizedBox(height: 10),

              Text(
                "We reserve the right to update these Terms & Conditions at any time. Updated versions will become effective when published within the application.",
                style: bodyStyle,
              ),

              SizedBox(height: 28),

              Text("11. Contact", style: headingStyle),

              SizedBox(height: 10),

              Text(
                "For questions regarding these Terms & Conditions, please contact:\n\nalbertomoyajimenez@hotmail.com",
                style: bodyStyle,
              ),

              SizedBox(height: 28),

              Text("12. Governing Law", style: headingStyle),

              SizedBox(height: 10),

              Text(
                "These Terms & Conditions shall be governed by the applicable laws governing the operation of this application.",
                style: bodyStyle,
              ),

              SizedBox(height: 40),

            ],
          ),
        ),
      ),
    );
  }
}