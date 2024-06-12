import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_nidhin/constants/env/colors.dart';
import 'package:news_app_nidhin/models/article.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppColors.cornflowerRed.withOpacity(0.2),
                blurRadius: 2,
                offset: const Offset(2, 2),
              ),
            ]),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ?? '',
                height: 100,
                width: double.infinity,
                errorWidget: (context, _, __) {
                  return Image.asset(
                    'assets/images/error_image.jpg',
                    fit: BoxFit.cover,
                  );
                },
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              article.title ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
