import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  final String url;

  const WebViewPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text("Full Article"),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.blue,
        iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.white),
        titleTextStyle: TextStyle(
          color: isDarkMode ? Colors.white : Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: WebViewWidget(
        controller: WebViewController()
          ..loadRequest(Uri.parse(url))
          ..setBackgroundColor(isDarkMode ? Colors.black : Colors.white),
      ),
    );
  }
}
