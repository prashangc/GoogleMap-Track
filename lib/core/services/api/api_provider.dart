import 'dart:async';
import 'dart:developer';

import 'package:blog/core/constants/strings.dart';
import 'package:blog/core/services/api/custom_exception.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://newsapi.org",
      responseType: ResponseType.json,
      contentType: "application/json ",
      receiveDataWhenStatusError: true,
      sendTimeout: const Duration(seconds: 1),
    ),
  );

  ApiProvider() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          options.headers['ACCEPT'] = 'application/json';
          options.headers['content-type'] = 'application/json';
          options.headers['origin'] = '*';
          return handler.next(options);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          return handler.next(error);
        },
      ),
    );
  }

  static Future<Response> callApi() async {
    try {
      Response response =
          await dio.get(Strings.baseUrl).timeout(const Duration(seconds: 30));
      return response;
    } on Exception catch (e) {
      return exceptionHandler(e: e);
    }
  }

  static exceptionHandler({required Exception e}) async {
    log(e.toString());
    if (e is DioException) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          throw UnauthorisedException("UnauthorisedException");
        } else if (e.response!.statusCode == 400) {
          throw ResourceNotFoundException("ResourceNotFoundException");
        } else if (e.response!.statusCode! < 500) {
          throw BadRequestException("BadRequestException");
        } else if (e.response!.statusCode == 500) {
          throw InternalServerErrorException();
        } else {
          throw UnknownException();
        }
      }
    } else if (e is TimeoutException) {
      throw TimeoutException('Request Timeout !!! Please try again.');
    } else {
      throw UnknownException();
    }
  }
}
