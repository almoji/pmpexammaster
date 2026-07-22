import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../models/exam_result.dart';

class ExamTrendCard extends StatelessWidget {
  final List<ExamResult> results;

  const ExamTrendCard({
    super.key,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return const SizedBox.shrink();
    }

    final spots = <FlSpot>[];

    for (int i = 0; i < results.length; i++) {
      spots.add(
        FlSpot(
          i.toDouble(),
          results[i].percentage.toDouble(),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Exam Trend',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: (results.length * 70).clamp(320, 2000).toDouble(),
                height: 240,
                child: LineChart(
                  LineChartData(
                    minY: 0,
                    maxY: 100,

                    minX: 0,
                    maxX: (results.length - 1).toDouble(),

                    gridData: FlGridData(
                      show: true,
                      horizontalInterval: 20,
                      drawVerticalLine: false,
                    ),

                    borderData: FlBorderData(
                      show: true,
                    ),

                    extraLinesData: ExtraLinesData(
                      horizontalLines: [
                        HorizontalLine(
                          y: 70,
                          color: Colors.green,
                          strokeWidth: 2,
                          dashArray: [6, 4],
                          label: HorizontalLineLabel(
                            show: true,
                            alignment: Alignment.topRight,
                            labelResolver: (_) => 'Passing Score',
                          ),
                        ),
                      ],
                    ),

                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          interval: 20,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(fontSize: 11),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();

                            if (index < 0 || index >= results.length) {
                              return const SizedBox.shrink();
                            }

                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                'E${index + 1}',
                                style: const TextStyle(fontSize: 11),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    lineTouchData: LineTouchData(
                      handleBuiltInTouches: true,
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipItems: (touchedSpots) {
                          return touchedSpots.map((spot) {
                            final exam = results[spot.x.toInt()];

                            return LineTooltipItem(
                              'Exam ${spot.x.toInt() + 1}\n'
                                  '${exam.percentage.toStringAsFixed(1)}%\n'
                                  '${exam.passed ? "PASSED" : "FAILED"}',
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),

                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        barWidth: 4,
                        isStrokeCapRound: true,

                        color: Colors.blue,

                        dotData: const FlDotData(
                          show: true,
                        ),

                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.blue.withValues(alpha: 0.30),
                              Colors.blue.withValues(alpha: 0.05),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}