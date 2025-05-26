import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:news_app/app/model/article_model.dart'; 

import '../services/news_service.dart'; 

class NewsController extends GetxController {
 
  var articles = <ArticleModel>[].obs;
  var filteredArticles = <ArticleModel>[].obs; 
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchNews();
    ever(articles, (_) => _updateFilteredArticles()); 
    super.onInit();
  }

  void fetchNews() async {
    try {
      isLoading.value = true;

      final fetchedData = await NewsService.fetchArticles();
      articles.assignAll(fetchedData); 
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch news: $e', snackPosition: SnackPosition.BOTTOM);
      if (kDebugMode) {
        print('Error fetching news: $e');
      } 
    } finally {
      isLoading.value = false;
    }
  }

  
  void searchNews(String query) {
    if (query.isEmpty) {
      filteredArticles.assignAll(articles); 
    } else {
      final lowerCaseQuery = query.toLowerCase();
      filteredArticles.assignAll(articles.where((article) {
        return article.title.toLowerCase().contains(lowerCaseQuery) ||
               article.description.toLowerCase().contains(lowerCaseQuery) ||
               article.sourceName.toLowerCase().contains(lowerCaseQuery); 
      }).toList());
    }
  }


  void _updateFilteredArticles() {
    filteredArticles.assignAll(articles);
  }
}