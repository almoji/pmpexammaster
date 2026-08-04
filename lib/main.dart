import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
RouteObserver<ModalRoute<void>>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await MobileAds.instance.initialize();

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

      navigatorObservers: [
        routeObserver,
      ],

      home: const HomeScreen(),
    );
  }
}