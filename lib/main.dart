import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const PMPExamApp());
}

class PMPExamApp extends StatelessWidget {
  const PMPExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PMP Exam Master',

      theme: AppTheme.lightTheme,

      home: const HomeScreen(),
    );
  }
}