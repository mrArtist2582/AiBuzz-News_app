import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/app/controller/bookmark_controller.dart';
import 'package:news_app/app/controller/news_controller.dart';
import 'package:news_app/app/services/storage_service.dart';
import 'package:news_app/app/views/login_page.dart';
import 'package:news_app/app/views/webview_page.dart';

class NewsPage extends StatelessWidget {
  final newsController = Get.put(NewsController());
  final bookmarkController = Get.put(BookmarkController());

  NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("KD News"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              StorageService.setLoggedIn(false);
              Get.offAll(() => LoginPage());
              Get.snackbar("Logout", "Successfully logged out");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              onChanged: newsController.searchNews,
              decoration: InputDecoration(
                hintText: 'Search News...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (newsController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              return RefreshIndicator(
                onRefresh: () async => newsController.fetchNews(),
                child: ListView.builder(
                  itemCount: newsController.filteredArticles.length,
                  itemBuilder: (context, index) {
                    final article = newsController.filteredArticles[index];
                    final isBookmarked = bookmarkController.isBookmarked(
                      article.url,
                    );

                    return Card(
                      margin: EdgeInsets.all(10),
                      clipBehavior: Clip.antiAlias, // Ensures the image respects the card's border radius
                      child: InkWell( // Use InkWell for ripple effect on tap
                        onTap: () => Get.to(() => WebViewPage(url: article.url)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ignore: unnecessary_null_comparison
                            if (article.urlToImage != null && article.urlToImage.isNotEmpty)
                              Image.network(
                                article.urlToImage,
                                height: 200, // Adjust height as needed
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 200,
                                    color: Colors.grey[200],
                                    child: Center(
                                      child: Icon(Icons.broken_image, color: Colors.grey),
                                    ),
                                  );
                                },
                              ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.title,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    article.description,
                                    style: TextStyle(fontSize: 14),
                                    maxLines: 3, // Limit description to 3 lines
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${article.sourceName} • ${article.getFormattedDate()}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                          overflow: TextOverflow.ellipsis, // Prevent text overflow
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          isBookmarked ? Icons.bookmark : Icons.bookmark_border, // Changed icon for better visual cue
                                          color: isBookmarked ? Colors.blue : Colors.grey,
                                        ),
                                        onPressed: () {
                                          if (isBookmarked) {
                                            bookmarkController.removeBookmark(article.url);
                                          } else {
                                            bookmarkController.addBookmark(article);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}