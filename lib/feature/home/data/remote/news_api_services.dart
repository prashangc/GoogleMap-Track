import 'package:blog/core/services/api/api_provider.dart';
import 'package:blog/feature/home/data/remote/inews_api_services.dart';
import 'package:dio/dio.dart';

class NewsApiService implements NewsApiServiceInterface {
  @override
  Future<Response> fetchNews() async {
    return await ApiProvider.callApi();
  }
}
