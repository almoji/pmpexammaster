import 'package:flutter/material.dart';

class PerformanceOverview extends StatelessWidget {
  const PerformanceOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 30,
            spreadRadius: -8,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              const Expanded(
                child: Text(
                  "Performance Overview",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF173B7A),
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF4FF),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  "THIS WEEK",
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: .6,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D86FF),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 26),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  fit: StackFit.expand,
                  children: [

                    CircularProgressIndicator(
                      value: .83,
                      strokeWidth: 12,
                      backgroundColor: const Color(0xFFE9EFF8),
                      color: const Color(0xFF2D86FF),
                    ),

                    const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text(
                            "83%",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF173B7A),
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            "Accuracy",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF7A879D),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 24),

              const Expanded(
                child: Column(
                  children: [

                    _DomainBar(
                      title: "People",
                      value: .81,
                      color: Color(0xFF4D9CFF),
                    ),

                    SizedBox(height: 18),

                    _DomainBar(
                      title: "Process",
                      value: .86,
                      color: Color(0xFF48C774),
                    ),

                    SizedBox(height: 18),

                    _DomainBar(
                      title: "Business Environment",
                      value: .79,
                      color: Color(0xFFF4A623),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Row(
            children: [

              Expanded(
                child: _Metric(
                  icon: Icons.check_circle_outline,
                  color: Color(0xFF48C774),
                  value: "248",
                  label: "Correct",
                ),
              ),

              SizedBox(width: 14),

              Expanded(
                child: _Metric(
                  icon: Icons.cancel_outlined,
                  color: Color(0xFFFF6B6B),
                  value: "52",
                  label: "Wrong",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  const _Metric({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFD),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [

          CircleAvatar(
            radius: 18,
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(icon, color: color, size: 20),
          ),

          const SizedBox(width: 12),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF173B7A),
                ),
              ),

              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF7A879D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DomainBar extends StatelessWidget {
  final String title;
  final double value;
  final Color color;

  const _DomainBar({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (value * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Color(0xFF173B7A),
                ),
              ),
            ),

            Text(
              "$percent%",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF173B7A),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 10,
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: const Color(0xFFE8EEF7),
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}