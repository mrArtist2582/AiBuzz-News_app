import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/app/controller/login_controller.dart';


class LoginPage extends StatelessWidget {
  final loginController = Get.put(LoginController());

     LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Login', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                SizedBox(height: 32),
                TextField(
                  controller: loginController.emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: loginController.passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: loginController.login,
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
