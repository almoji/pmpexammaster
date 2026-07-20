import 'package:flutter/material.dart';

import 'screens/home_screen.dart';


void main() {

  runApp(const PMPExamApp());

}


class PMPExamApp extends StatelessWidget {

  const PMPExamApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'PMP Exam',

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),

      ),

      home: const HomeScreen(),

    );

  }

}