import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/app/controller/bookmark_controller.dart';
import 'package:news_app/app/views/webview_page.dart';

class BookmarkPage extends StatelessWidget {
  final bookmarkController = Get.find<BookmarkController>();

 BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (bookmarkController.bookmarks.isEmpty) {
        return Center(child: Text('No bookmarks yet.'));
      }

      return ListView.builder(
        itemCount: bookmarkController.bookmarks.length,
        itemBuilder: (context, index) {
          final article = bookmarkController.bookmarks[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: article.urlToImage.isNotEmpty
                  ? Image.network(article.urlToImage, width: 100, fit: BoxFit.cover)
                  : null,
              title: Text(article.title),
              subtitle: Text(article.sourceName),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => bookmarkController.removeBookmark(article.url),
              ),
              onTap: () => Get.to(() => WebViewPage(url: article.url)),
            ),
          );
        },
      );
    });
  }
}
