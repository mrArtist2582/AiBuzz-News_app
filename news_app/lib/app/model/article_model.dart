
// ignore: unused_import
import 'dart:convert'; 
class ArticleModel {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String sourceName;

  ArticleModel({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.sourceName,
  });

 
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    String? name;
  
    if (json['source'] != null && json['source']['name'] != null) {
      name = json['source']['name'] as String;
    }

    return ArticleModel(
      title: json['title'] as String? ?? 'No Title',
      description: json['description'] as String? ?? 'No Description',
      url: json['url'] as String? ?? '',
      urlToImage: json['urlToImage'] as String? ?? '',
      publishedAt: json['publishedAt'] as String? ?? '',
      sourceName: name ?? 'No Publisher', 
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
    
      'source': {'id': null, 'name': sourceName}, 
    };
  }


  String getFormattedDate() {
    try {
      if (publishedAt.isEmpty) {
        return 'Unknown Date';
      }
      final dateTime = DateTime.parse(publishedAt);
     
      return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
    } catch (e) {
      return 'Unknown Date';
    }
  }
}