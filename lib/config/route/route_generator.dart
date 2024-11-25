import 'package:blog/config/route/routes.dart';
import 'package:blog/feature/home/presentation/ui/home_screen.dart';
import 'package:blog/feature/map/presentation/ui/custom_map.dart';
import 'package:blog/feature/news/presentation/ui/news_details_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.root:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.map:
        return MaterialPageRoute(builder: (_) => const CustomMapScreen());
      case Routes.news:
        final args = settings.arguments as NewsDetailsScreen;
        return MaterialPageRoute(
          builder: (_) => NewsDetailsScreen(articles: args.articles),
        );
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
