import '../models/exam_result.dart';
import 'package:flutter/material.dart';

class ExamStatisticsService {

  final List<ExamResult> results;

  ExamStatisticsService({
    required this.results,
  });

  double get averageScore {

    if (results.isEmpty) {
      return 0;
    }

    final total = results.fold<int>(
      0,
          (sum, result) => sum + result.percentage,
    );

    return total / results.length;

  }

  int get bestScore {

    if (results.isEmpty) {
      return 0;
    }

    return results
        .map((result) => result.percentage)
        .reduce((a, b) => a > b ? a : b);

  }

  String get status {

    if (averageScore >= 85) {
      return "PMP Ready 🚀";
    }

    if (averageScore >= 70) {
      return "Good Progress";
    }

    if (averageScore >= 50) {
      return "Improving";
    }

    return "Needs Improvement";

  }

  Color get statusColor {

    switch (status) {

      case "PMP Ready 🚀":
        return Colors.green;

      case "Good Progress":
        return Colors.lightGreen;

      case "Improving":
        return Colors.orange;

      default:
        return Colors.red;

    }

  }

}