import 'package:altayer_assignment/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key, required this.article});
  final Article article;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => await launchUrl(Uri.parse(article.url)),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the article image if available
            if (article.urlToImage.isNotEmpty)
              Image.network(
                article.urlToImage,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
