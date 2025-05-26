import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/theme_controller.dart';
import 'views/login_page.dart';
import 'views/home_page.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KD News App',
        theme: themeController.isDark.value ? ThemeData.dark() : ThemeData.light(),
        home: StorageService.isLoggedIn() ? HomePage() : LoginPage(),
      );
    });
  }
}