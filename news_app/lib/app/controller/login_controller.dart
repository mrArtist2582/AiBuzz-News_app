import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../views/home_page.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || !email.contains('@') || password.isEmpty) {
      Get.snackbar('Error', 'Please enter valid email and password');
      return;
    }

    // Mock login logic
    StorageService.setLoggedIn(true);
    Get.offAll(() => HomePage());
  }
}
