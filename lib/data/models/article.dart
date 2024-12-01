import 'package:news_flow/data/models/source.dart';

class Article {
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final Source source;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.source
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      url: json['url'],
      urlToImage: json['urlToImage'],
      source: Source.fromJson(json['source']),
    );
  }
}