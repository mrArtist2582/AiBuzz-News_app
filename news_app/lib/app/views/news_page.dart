import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/app/controller/bookmark_controller.dart';
import 'package:news_app/app/controller/news_controller.dart';
import 'package:news_app/app/views/webview_page.dart';

class NewsPage extends StatelessWidget {
  final newsController = Get.put(NewsController());
  final bookmarkController = Get.put(BookmarkController());

 NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (newsController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      return RefreshIndicator(
        onRefresh: () async => newsController.fetchNews(),
        child: ListView.builder(
          itemCount: newsController.articles.length,
          itemBuilder: (context, index) {
            final article = newsController.articles[index];
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: article.urlToImage.isNotEmpty
                    ? Image.network(article.urlToImage, width: 100, fit: BoxFit.cover)
                    : null,
                title: Text(article.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(article.description),
                    SizedBox(height: 6),
                    Text(
                      '${article.sourceName} • ${article.getFormattedDate()}',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.bookmark_add),
                  onPressed: () => bookmarkController.addBookmark(article),
                ),
                onTap: () => Get.to(() => WebViewPage(url: article.url)),
              ),
            );
          },
        ),
      );
    });
  }
}
