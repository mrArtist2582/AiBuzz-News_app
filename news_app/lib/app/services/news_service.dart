import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/app/model/article_model.dart';

class NewsService {
  static const String _apiKey = 'd64e27898d88406287da2b914d535d98';
  static const String _baseUrl = 'https://newsapi.org/v2/top-headlines';

  static Future<List<ArticleModel>> fetchArticles({
    String country = 'us',
    String category = 'general',
    String? query,
  }) async {
    Uri uri;
    if (query != null && query.isNotEmpty) {
      uri = Uri.parse(
        'https://newsapi.org/v2/everything?q=$query&sortBy=relevancy&apiKey=$_apiKey',
      );
    } else {
      uri = Uri.parse(
        '$_baseUrl?country=$country&category=$category&apiKey=$_apiKey',
      );
    }

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Check if 'status' is 'ok' and 'articles' array exists
        if (data['status'] == 'ok' && data['articles'] is List) {
          final List articlesJson = data['articles'];

          return articlesJson
              .map(
                (json) => ArticleModel.fromJson(json as Map<String, dynamic>),
              )
              .toList();
        } else {
          final String errorMessage = data['message'] ?? 'Unknown API error';
          throw Exception('API Response Error: $errorMessage');
        }
      } else {
        String errorBody = response.body.isNotEmpty
            ? jsonDecode(response.body)['message']
            : 'Unknown error';
        throw Exception(
          'Failed to load news. Status Code: ${response.statusCode}. Error: $errorBody',
        );
      }
    } on http.ClientException catch (e) {
      throw Exception(
        'Network Error: Could not connect to the news server. Please check your internet connection. ($e)',
      );
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
