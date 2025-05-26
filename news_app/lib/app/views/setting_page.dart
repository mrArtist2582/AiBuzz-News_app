import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/app/controller/theme_controller.dart';


class SettingsPage extends StatelessWidget {
  final themeController = Get.find<ThemeController>();

SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(title: Text('Settings')),
          body: ListView(
            children: [
              SwitchListTile(
                title: Text('Dark Mode'),
                value: themeController.isDark.value,
                onChanged: (value) => themeController.toggleTheme(),
              ),
            ],
          ),
        ));
  }
}
