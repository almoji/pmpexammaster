import 'package:flutter/material.dart';

class PracticeHeader extends StatelessWidget {
  const PracticeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        Text(
          "Choose your study session",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF74829C),
          ),
        ),
      ],
    );
  }
}