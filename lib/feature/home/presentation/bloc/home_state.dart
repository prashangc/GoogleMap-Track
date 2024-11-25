import 'package:blog/feature/home/data/model/news_model.dart';

abstract class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final NewsModel newsModel;
  HomeSuccessState({required this.newsModel});
}

class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState({required this.error});
}
