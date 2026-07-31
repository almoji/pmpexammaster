import 'package:flutter/material.dart';

import '../services/dashboard_statistics_service.dart';
import '../services/question_attempt_service.dart';
import '../screens/practice_setup_screen.dart';


import '../widgets/home/bottom_banner.dart';
import '../widgets/home/goal_card.dart';
import '../widgets/home/header_section.dart';
import '../widgets/home/performance_overview.dart';
import '../widgets/home/quick_actions.dart';
import '../widgets/home/recent_activity.dart';
import '../widgets/home/weakest_domain.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const double _sidePadding = 22;
  static const double _sectionSpacing = 26;

  /// Temporal hasta crear Settings
  static const int _dailyGoal = 35;

  DashboardStatisticsService? _statistics;

  int get _questionsToday => _statistics?.questionsToday ?? 0;

  double get _todayAccuracy => _statistics?.todayAccuracy ?? 0;

  int get _studyMinutes =>
      ((_statistics?.studyTimeToday ?? 0) / 60).round();

  String get _weakestDomain {
    if (_statistics == null ||
        _statistics!.domainStatistics.isEmpty) {
      return "No data";
    }

    final weakest = _statistics!.domainStatistics.values.reduce(
          (a, b) => a.percentage < b.percentage ? a : b,
    );

    return weakest.domain;
  }

  double get _weakestScore {
    if (_statistics == null ||
        _statistics!.domainStatistics.isEmpty) {
      return 0;
    }

    final weakest = _statistics!.domainStatistics.values.reduce(
          (a, b) => a.percentage < b.percentage ? a : b,
    );

    return weakest.percentage;
  }

  @override
  void initState() {
    super.initState();


    _loadStatistics();
  }

  Future<void> _loadStatistics() async {
    final attempts = await QuestionAttemptService().getAttempts();



    setState(() {
      _statistics = DashboardStatisticsService(
        attempts: attempts,
      );
    });
  }

  Future<void> _refreshStatistics() async {
    final attempts = await QuestionAttemptService().getAttempts();

    if (!mounted) return;

    setState(() {
      _statistics = DashboardStatisticsService(
        attempts: attempts,
      );
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          const HeaderSection(),

          Transform.translate(
            offset: const Offset(0, -42),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: _sidePadding,
              ),
              child: GoalCard(
                completed: _questionsToday,
                goal: _dailyGoal,
                accuracy: _todayAccuracy,
                studyMinutes: _studyMinutes,
              ),
            ),
          ),

          const SizedBox(height: 8),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: _sidePadding),
            child: QuickActions(),
          ),

          const SizedBox(height: _sectionSpacing),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: _sidePadding),
            child: PerformanceOverview(),
          ),

          const SizedBox(height: _sectionSpacing),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: _sidePadding,
            ),
            child: WeakestDomain(
              domain: _weakestDomain,
              score: _weakestScore,
              onPractice: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PracticeSetupScreen(
                      initialDomain: _weakestDomain,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: _sectionSpacing),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: _sidePadding),
            child: RecentActivity(),
          ),

          const SizedBox(height: _sectionSpacing),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: _sidePadding),
            child: BottomBanner(),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}