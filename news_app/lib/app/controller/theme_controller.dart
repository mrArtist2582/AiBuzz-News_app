import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  var isDark = false.obs;

  @override
  void onInit() {
    _loadTheme();
    super.onInit();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    isDark.value = prefs.getBool('isDarkTheme') ?? false;
  }

  void toggleTheme() async {
    isDark.value = !isDark.value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isDark.value);
  }
}
