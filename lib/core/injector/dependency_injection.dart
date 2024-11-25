import 'package:blog/feature/home/data/remote/news_api_services.dart';
import 'package:blog/feature/home/data/repo/news_repository.dart';
import 'package:blog/feature/home/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

class GetItServices {
  static final getIt = GetIt.instance;

  static Future<void> serviceLocator() async {
    getIt.registerFactory(() => NewsApiService());
    getIt.registerFactory(
        () => NewsRepository(newsApiService: getIt<NewsApiService>()));
    getIt.registerFactory(
        () => HomeBloc(newsRepository: getIt<NewsRepository>()));
  }
}
