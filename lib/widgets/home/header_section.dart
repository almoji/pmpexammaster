import 'package:flutter/material.dart';
import '../../screens/settings_screen.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        children: [

          /// Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: -18,
            child: Image.asset(
              "assets/images/header_background.png",
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),

          SafeArea(
            child: Stack(
              children: [

                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Image.asset(
                      "assets/icon/logo_horizontal.png",
                      height: 80,
                    ),
                  ),
                ),

                Positioned(
                  top: 0,
                  right: 18,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.settings_rounded,
                        color: Colors.white,
                        size: 26,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SettingsScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}