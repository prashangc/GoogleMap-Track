import 'package:blog/core/widgets/appbar/custom_appbar.dart';
import 'package:blog/core/widgets/text/custom_text.dart';
import 'package:blog/feature/home/data/model/news_model.dart';
import 'package:blog/feature/news/presentation/widgets/news_share.dart';
import 'package:flutter/material.dart';

class NewsDetailsScreen extends StatelessWidget {
  final Articles articles;
  const NewsDetailsScreen({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: articles.author ?? articles.title.toString()),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(12.0),
        child: CustomText(text: articles.content.toString()),
      ),
      floatingActionButton: ShareNews(articles: articles),
    );
  }
}
