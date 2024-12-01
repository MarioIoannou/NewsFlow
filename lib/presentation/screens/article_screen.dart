import 'package:flutter/material.dart';
import 'package:news_flow/data/models/article.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.source.name),
      ),
      // body: WebView(
      //   initialUrl: article.url,
      //   javascriptMode: JavascriptMode.unrestricted,
      // ),
    );
  }
}