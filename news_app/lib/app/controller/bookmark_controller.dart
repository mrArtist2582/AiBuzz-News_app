import 'package:flutter/foundation.dart';
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


  void loadBookmarks() async {
    try {
 
      final List<String> data = await StorageService.getBookmarks(); 

    
      bookmarks.assignAll(data.map((e) {
        try {
      
          return ArticleModel.fromJson(jsonDecode(e) as Map<String, dynamic>);
        } catch (decodeError) {
 
          if (kDebugMode) {
            print('Error decoding bookmark JSON from storage: $decodeError, Data: $e');
          }
      
          return ArticleModel(
            title: 'Corrupted Bookmark',
            description: 'This bookmark could not be loaded due to data corruption.',
            url: 'corrupted_url_${DateTime.now().millisecondsSinceEpoch}', 
            urlToImage: '',
            publishedAt: '',
            sourceName: 'System Error',
          );
        }
      }).toList());
    } catch (e) {
    
      if (kDebugMode) {
        print('Overall error loading bookmarks: $e');
      }
      Get.snackbar('Error', 'Failed to load bookmarks from storage.');
    }
  }

  void addBookmark(ArticleModel article) async {
 
    if (!bookmarks.any((a) => a.url == article.url)) {
      bookmarks.add(article); 
    
      await StorageService.saveBookmark(article.toJson());
      Get.snackbar('Bookmark Added', article.title, snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Already Bookmarked', 'This article is already in your bookmarks.', snackPosition: SnackPosition.BOTTOM);
    }
  }

  void removeBookmark(String url) async {
 
    bookmarks.removeWhere((a) => a.url == url);
   
    await StorageService.removeBookmark(url);
    Get.snackbar('Bookmark Removed', 'Article removed from bookmarks.', snackPosition: SnackPosition.BOTTOM);
  }

  bool isBookmarked(String url) {
    return bookmarks.any((a) => a.url == url);
  }
}