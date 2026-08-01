import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
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
        child: const SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                "Privacy Policy",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF173B7A),
                ),
              ),

              SizedBox(height: 20),

              Text(
                "PMP Exam Master respects your privacy. "
                    "We only store the information required to provide your study experience.",

                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                ),
              ),

              SizedBox(height: 24),

              Text(
                "Information Stored",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "• Exam history\n"
                    "• Practice results\n"
                    "• Dashboard statistics\n"
                    "• Study progress",

                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                ),
              ),

              SizedBox(height: 24),

              Text(
                "Data Sharing",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "Your data is stored locally on your device. "
                    "We do not sell or share your personal information with third parties.",

                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                ),
              ),

              SizedBox(height: 30),

              Text(
                "Last updated: August 2026",
                style: TextStyle(
                  color: Color(0xFF74829C),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}