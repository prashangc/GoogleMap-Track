import 'package:blog/core/services/network/network_response.dart';
import 'package:blog/feature/home/data/model/news_model.dart';

abstract class NewsRepositoryInterface {
  Future<DataResponse<NewsModel>> fetchNews();
}
