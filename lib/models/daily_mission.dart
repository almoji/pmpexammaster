enum MissionAction {
  practice,
  mockExam,
  reviewWrongAnswers,
  reviewDomain,
}

class DailyMission {
  final String title;
  final String description;
  final List<String> reasons;
  final MissionAction action;
  final String? domain;
  final int questionCount;
  final int expectedReadinessGain;

  const DailyMission({
    required this.title,
    required this.description,
    required this.reasons,
    required this.action,
    this.domain,
    this.questionCount = 0,
    this.expectedReadinessGain = 0,
  });
}