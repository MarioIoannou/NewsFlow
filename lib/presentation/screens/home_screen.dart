import 'package:flutter/material.dart';
import 'package:news_flow/data/models/article.dart';
import 'package:news_flow/data/providers/news_provider.dart';
import 'package:news_flow/data/providers/theme_provider.dart';
import 'package:news_flow/presentation/screens/article_screen.dart';
import 'package:news_flow/presentation/screens/settings_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  late NewsProvider _newsProvider;

  @override
  void initState() {
    super.initState();
    _newsProvider = NewsProvider();
    _newsProvider.fetchArticles();
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(

      appBar: AppBar(
        title: const Text('News Aggregator'),
        actions: [

          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.dark
                ? Icons.brightness_7
                : Icons.brightness_2),
            onPressed: () {
              themeProvider.toggleTheme(themeProvider.themeMode != ThemeMode.dark);
            },
          ),

          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),

        ],
      ),
      
      body: FutureBuilder<List<Article>>(

        future: _newsProvider.fetchArticles(),
        builder: (context, snapshot) {

          if (snapshot.hasData) {

            final articles = snapshot.data!;

            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (_, index) {

                final article = articles[index];
                
                return ListTile(
                  leading: article.urlToImage != null
                      ? Image.network(
                          article.urlToImage!,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                      : null,
                  title: Text(article.title),
                  subtitle: Text(article.source.name),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ArticleDetailScreen(article: article),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching articles.'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}