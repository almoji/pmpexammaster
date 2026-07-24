import 'mission_type.dart';

class DailyStrategy {
  final MissionType missionType;
  final int questionCount;
  final String title;
  final String reason;
  final String goal;

  const DailyStrategy({
    required this.missionType,
    required this.questionCount,
    required this.title,
    required this.reason,
    required this.goal,
  });
}