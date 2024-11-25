import 'package:blog/core/services/network/network_response.dart';
import 'package:blog/feature/home/data/model/news_model.dart';
import 'package:blog/feature/home/data/remote/news_api_services.dart';
import 'package:blog/feature/home/domain/repo/inews_repository.dart';
import 'package:dio/dio.dart';

class NewsRepository implements NewsRepositoryInterface {
  final NewsApiService newsApiService;
  const NewsRepository({required this.newsApiService});

  @override
  Future<DataResponse<NewsModel>> fetchNews() async {
    try {
      Response res = await newsApiService.fetchNews();
      return DataResponse.completed(NewsModel.fromJson(res.data));
    } catch (e) {
      return DataResponse.error("Error !!! Something went wrong");
    }
  }
}
