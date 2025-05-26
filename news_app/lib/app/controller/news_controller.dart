import 'package:get/get.dart';
import 'package:news_app/app/model/article_model.dart';

import '../services/news_service.dart';

class NewsController extends GetxController {
  var articles = <ArticleModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  void fetchNews() async {
    try {
      isLoading.value = true;
      final data = await NewsService.fetchArticles();
      articles.assignAll(data);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch news');
    } finally {
      isLoading.value = false;
    }
  }
}
