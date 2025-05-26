import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/app/controller/theme_controller.dart';

class ThemeToggleSwitch extends StatelessWidget {
  final ThemeController themeController = Get.find<ThemeController>();

  ThemeToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDarkMode = themeController.isDarkMode.value;

      final Color lightTrackColor = Colors.lightBlue.shade200;
      final Color darkTrackColor = Colors.blueGrey.shade900;
      final Color currentTrackColor = isDarkMode ? darkTrackColor : lightTrackColor;

      final Color lightThumbColor = Colors.white;
      final Color darkThumbColor = Colors.grey.shade900;
      final Color currentThumbColor = isDarkMode ? darkThumbColor : lightThumbColor;

      final IconData activeIcon = isDarkMode ? Icons.dark_mode : Icons.light_mode;
      final Color activeIconColor = isDarkMode ? Colors.yellow.shade400 : Colors.amber.shade600;

      // ignore: deprecated_member_use
      final Color inactiveMoonColor = Colors.blueGrey.shade600.withOpacity(0.3);
      // ignore: deprecated_member_use
      final Color inactiveSunColor = Colors.amber.shade300.withOpacity(0.3);

      return GestureDetector(
        onTap: () => themeController.toggleTheme(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutBack,
          width: 100,
          height: 45,
          decoration: BoxDecoration(
            color: currentTrackColor,
            borderRadius: BorderRadius.circular(22.5),
            border: Border.all(
              // ignore: deprecated_member_use
              color: isDarkMode ? Colors.white.withOpacity(0.3) : Colors.grey.shade400,
              width: 1.0,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 10,
                child: AnimatedOpacity(
                  opacity: isDarkMode ? 1.0 : 0.2,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(Icons.dark_mode, color: inactiveMoonColor, size: 28),
                ),
              ),
              Positioned(
                right: 10,
                child: AnimatedOpacity(
                  opacity: isDarkMode ? 0.2 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(Icons.light_mode, color: inactiveSunColor, size: 28),
                ),
              ),
              AnimatedAlign(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOutBack,
                alignment: isDarkMode ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                    color: currentThumbColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(isDarkMode ? 0.4 : 0.2),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    activeIcon,
                    color: activeIconColor,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}