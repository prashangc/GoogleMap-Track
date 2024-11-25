import 'package:blog/feature/home/data/model/news_model.dart';
import 'package:blog/feature/home/presentation/widgets/home_news_item.dart';
import 'package:flutter/material.dart';

class HomeListView extends StatelessWidget {
  final NewsModel newsModel;
  const HomeListView({super.key, required this.newsModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: newsModel.articles!.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(12.0),
      itemBuilder: (context, index) {
        return HomeNewsItem(articles: newsModel.articles![index]);
      },
    );
  }
}
