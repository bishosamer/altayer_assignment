import 'dart:convert';
import 'package:altayer_assignment/models/article_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  static final NewsRepository _instance = NewsRepository._internal();
  factory NewsRepository() => _instance;

  NewsRepository._internal();

  final String apiKey = const String.fromEnvironment("API_KEY");
  final String baseUrl = 'https://newsapi.org/v2';

  Future<List<Article>> fetchNewsByKeyword(String keyword) async {
    var response = await http.get(
      Uri.parse("$baseUrl/everything?q=$keyword&apiKey=$apiKey"),
    );
    if (response.statusCode == 200) {
      final parsedJson = jsonDecode(response.body);

      if (parsedJson['articles'] != null) {
        List<dynamic> articlesJson = parsedJson['articles'];
        List<Article> articles = articlesJson.map((articleJson) {
          return Article.fromJson(articleJson);
        }).toList();
        return articles;
      } else {
        return [];
      }
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
