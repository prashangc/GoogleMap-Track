import 'package:blog/config/route/nav.dart';
import 'package:blog/config/route/routes.dart';
import 'package:blog/core/extension/sizebox.dart';
import 'package:blog/core/widgets/image/custom_image_view.dart';
import 'package:blog/core/widgets/text/custom_text.dart';
import 'package:blog/feature/home/data/model/news_model.dart';
import 'package:blog/feature/news/presentation/ui/news_details_screen.dart';
import 'package:flutter/material.dart';

class HomeNewsItem extends StatelessWidget {
  final Articles articles;
  const HomeNewsItem({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Nav.push(
          route: Routes.news, arguments: NewsDetailsScreen(articles: articles)),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              MyCachedNetworkImage(
                myImage: articles.urlToImage.toString(),
                myWidth: 65.0,
                myHeight: 65.0,
              ),
              24.wGap,
              Expanded(
                child: CustomText(
                  text: articles.title.toString(),
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
