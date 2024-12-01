import 'dart:convert';

import 'package:news_flow/data/models/article.dart';
import 'package:http/http.dart' as http;

class NewsProvider {

  static const String _apiKey = 'cfa450c08a6e490790d6078ccf9933c4';
  static const String _baseUrl = 'https://newsapi.org/v2/top-headlines';
  
  Future<List<Article>> fetchArticles({String country = 'us'}) async {
    
    final response = await http.get(
      Uri.parse('$_baseUrl?country=$country&apiKey=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articlesJson = data['articles'];
      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}