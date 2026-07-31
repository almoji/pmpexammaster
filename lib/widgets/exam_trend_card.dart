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

        Container(

          decoration: BoxDecoration(

            color: Colors.white,

            borderRadius: BorderRadius.circular(24),

            boxShadow: [

              BoxShadow(

                color: Colors.black.withValues(alpha: 0.05),

                blurRadius: 22,

                spreadRadius: -6,

                offset: const Offset(0, 10),

              ),

            ],

          ),

          child: Padding(

            padding: const EdgeInsets.all(20),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

              const Text(

              "Your Exam Performance",

              style: TextStyle(

                fontSize: 18,

                fontWeight: FontWeight.bold,

                color: Color(0xFF173B7A),

              ),

            ),

            const SizedBox(height: 4),

            const Text(

              "Performance across your latest exams",

              style: TextStyle(

                fontSize: 14,

                color: Color(0xFF74829C),

              ),

            ),

            const SizedBox(height: 20),

            SingleChildScrollView(
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

                      getDrawingHorizontalLine: (value) {

                        return FlLine(

                          color: const Color(0xFFE9EEF6),

                          strokeWidth: 1,

                        );

                      },

                    ),

                    borderData: FlBorderData(
                      show: true,
                    ),

                    extraLinesData: ExtraLinesData(

                      horizontalLines: [

                        HorizontalLine(

                          y: 70,

                          color: const Color(0xFF18B76A),

                          strokeWidth: 2,

                          dashArray: [8, 4],

                          label: HorizontalLineLabel(

                            show: true,

                            alignment: Alignment.topRight,

                            style: const TextStyle(

                              fontSize: 11,

                              color: Color(0xFF18B76A),

                              fontWeight: FontWeight.bold,

                            ),

                            labelResolver: (_) => "PASS",

                          ),

                        ),

                        HorizontalLine(

                          y: 85,

                          color: const Color(0xFF7A4DFF),

                          strokeWidth: 2,

                          dashArray: [8, 4],

                          label: HorizontalLineLabel(

                            show: true,

                            alignment: Alignment.topRight,

                            style: const TextStyle(

                              fontSize: 11,

                              color: Color(0xFF7A4DFF),

                              fontWeight: FontWeight.bold,

                            ),

                            labelResolver: (_) => "TARGET",

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

                          reservedSize: 42,

                          interval: 20,

                          getTitlesWidget: (value, meta) {

                            return Text(

                              "${value.toInt()}%",

                              style: const TextStyle(

                                fontSize: 11,

                                color: Color(0xFF9AA8BD),

                                fontWeight: FontWeight.w600,

                              ),

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
                                style: const TextStyle(

                                  fontSize: 12,

                                  fontWeight: FontWeight.w600,

                                  color: Color(0xFF74829C),

                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    lineTouchData: LineTouchData(

                      handleBuiltInTouches: true,

                      touchTooltipData: LineTouchTooltipData(

                        tooltipRoundedRadius: 16,

                        tooltipPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),

                        tooltipMargin: 12,

                        getTooltipColor: (_) => Colors.white,

                        getTooltipItems: (touchedSpots) {

                          return touchedSpots.map((spot) {

                            final exam = results[spot.x.toInt()];

                            return LineTooltipItem(

                              "${exam.percentage.toStringAsFixed(0)}%\n",

                              const TextStyle(

                                color: Color(0xFF173B7A),

                                fontWeight: FontWeight.bold,

                                fontSize: 18,

                              ),

                              children: [

                                TextSpan(

                                  text: exam.passed ? "PASSED" : "FAILED",

                                  style: TextStyle(

                                    color: exam.passed
                                        ? const Color(0xFF18B76A)
                                        : const Color(0xFFE5484D),

                                    fontWeight: FontWeight.w600,

                                    fontSize: 13,

                                  ),

                                ),

                              ],

                            );

                          }).toList();

                        },

                      ),

                    ),

                    lineBarsData: [

                      LineChartBarData(

                        spots: spots,

                        isCurved: true,

                        curveSmoothness: 0.35,

                        barWidth: 5,

                        isStrokeCapRound: true,

                        color: const Color(0xFF2D86FF),

                        dotData: FlDotData(

                          show: true,

                          getDotPainter: (spot, percent, bar, index) {

                            return FlDotCirclePainter(

                              radius: 5,

                              color: const Color(0xFF2D86FF),

                              strokeWidth: 3,

                              strokeColor: Colors.white,

                            );

                          },

                        ),

                        belowBarData: BarAreaData(

                          show: true,

                          gradient: LinearGradient(

                            begin: Alignment.topCenter,

                            end: Alignment.bottomCenter,

                            colors: [

                              const Color(0xFF2D86FF).withValues(alpha: .25),

                              const Color(0xFF2D86FF).withValues(alpha: .02),

                            ],

                          ),

                        ),

                      ),

                    ],
                  ),
                ),
              ),
            ),

              ], // <-- cierra children del Column

            ), // <-- cierra Column

          ), // <-- cierra Padding

        ), // <-- cierra Container

      ], // <-- cierra children del Column principal

    );

  }

}