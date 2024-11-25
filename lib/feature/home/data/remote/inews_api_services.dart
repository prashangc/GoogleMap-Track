import 'package:dio/dio.dart';

abstract class NewsApiServiceInterface {
  Future<Response> fetchNews();
}
