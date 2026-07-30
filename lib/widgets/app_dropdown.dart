import 'package:flutter/material.dart';

class AppDropdown<T> extends StatelessWidget {
  final T value;
  final List<DropdownMenuEntry<T>> entries;
  final ValueChanged<T> onChanged;

  const AppDropdown({
    super.key,
    required this.value,
    required this.entries,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      width: MediaQuery.of(context).size.width - 44,

      initialSelection: value,

      onSelected: (value) {
        if (value != null) {
          onChanged(value);
        }
      },

      textStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Color(0xFF173B7A),
      ),

      menuStyle: MenuStyle(
        backgroundColor: const WidgetStatePropertyAll(Colors.white),
        elevation: const WidgetStatePropertyAll(3),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF7F9FC),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFE2EBF7),
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFE2EBF7),
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFF2D86FF),
            width: 1.5,
          ),
        ),
      ),

      dropdownMenuEntries: entries,
    );
  }
}