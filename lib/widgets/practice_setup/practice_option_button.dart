import 'package:flutter/material.dart';

class PracticeOptionButton extends StatelessWidget {
  final String text;
  final bool selected;
  final double width;
  final VoidCallback onTap;

  const PracticeOptionButton({
    super.key,
    required this.text,
    required this.selected,
    required this.onTap,
    this.width = 82,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: width,
        height: 42,
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFEFF6FF)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? const Color(0xFF2D86FF)
                : const Color(0xFFE3EAF5),
            width: 1.3,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [

            Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: selected
                      ? const Color(0xFF1565C0)
                      : const Color(0xFF4A5568),
                ),
              ),
            ),

            if (selected)
              const Positioned(
                left: 10,
                child: Icon(
                  Icons.check_circle,
                  size: 18,
                  color: Color(0xFF2D86FF),
                ),
              ),
          ],
        ),
      ),
    );
  }
}