import 'package:get/get.dart';
import 'package:news_app/app/model/article_model.dart';
import 'dart:convert';

import '../services/storage_service.dart';

class BookmarkController extends GetxController {
  var bookmarks = <ArticleModel>[].obs;

  @override
  void onInit() {
    loadBookmarks();
    super.onInit();
  }

  void loadBookmarks() {
    final data = StorageService.getBookmarks();
    bookmarks.assignAll(data.map((e) => ArticleModel.fromJson(jsonDecode(e))).toList());
  }

  void addBookmark(ArticleModel article) async {
    if (!bookmarks.any((a) => a.url == article.url)) {
      bookmarks.add(article);
      await StorageService.saveBookmark(article.toJson());
    }
  }

  void removeBookmark(String url) async {
    bookmarks.removeWhere((a) => a.url == url);
    await StorageService.removeBookmark(url);
  }
}
