import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/app/controller/theme_controller.dart';
import 'package:news_app/app/services/storage_service.dart';
import 'package:news_app/app/theme/dark_theme.dart';
import 'package:news_app/app/theme/light_theme.dart';
import 'package:news_app/app/views/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KD News App',
        theme: themeController.isDark.value ? darkTheme : lightTheme,
        home: const SplashPage(), 
      );
    });
  }
}
