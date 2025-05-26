import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/app/controller/theme_controller.dart';
import 'package:news_app/app/views/setting_page.dart';
import 'news_page.dart';
import 'bookmark_page.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final pages = [
    NewsPage(),
    BookmarkPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final themeController = Get.find<ThemeController>();

    return Obx(() => Scaffold(
          body: pages[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.article), label: 'News'),
              BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Bookmarks'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        ));
  }
}
