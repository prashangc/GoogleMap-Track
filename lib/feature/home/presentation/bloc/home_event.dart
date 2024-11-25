import 'package:blog/feature/home/data/model/news_model.dart';

abstract class HomeEvent {}

class HomeLoadingEvent extends HomeEvent {}

class HomeFetchEvent extends HomeEvent {}

class HomeSuccessEvent extends HomeEvent {
  final NewsModel newsModel;
  HomeSuccessEvent({required this.newsModel});
}

class HomeErrorEvent extends HomeEvent {
  final String error;
  HomeErrorEvent({required this.error});
}
