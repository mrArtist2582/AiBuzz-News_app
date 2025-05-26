import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/app/model/article_model.dart';


class NewsService {
  static const String _apiKey = 'd64e27898d88406287da2b914d535d98';
  static const String _endpoint =
      'https://newsapi.org/v2/top-headlines?country=in&apiKey=$_apiKey';

  static Future<List<ArticleModel>> fetchArticles() async {
    try {
      final response = await http.get(Uri.parse(_endpoint));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List articles = data['articles'];

        return articles
            .map((json) => ArticleModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
