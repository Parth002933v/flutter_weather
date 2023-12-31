import 'package:dio/dio.dart';
import 'package:flutter_weather/common/utils/constants.dart';

class HttpUtil {
  late Dio _dio;

  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() {
    return _instance;
  }

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: AppConstants.SERVER_API_URL,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      contentType: "application/json: charset=utf-8",
      responseType: ResponseType.json,
    );

    _dio = Dio(options);
  }

  Future<Response> get(String city) async {
    const key = AppConstants.SERVER_API_KEY;

    final path = "/forecast.json?key=$key&q=$city&days=6";

    var responce = await _dio.get(path);

    return responce;
  }

  Future<Response> getOne(String city) async {
    const key = AppConstants.SERVER_API_KEY;

    final path = "/forecast.json?key=$key&q=$city";

    var responce = await _dio.get(path);

    return responce;
  }

  Future<Response> getCity(String city) async {
    const key = AppConstants.SERVER_API_KEY;

    final path = "/search.json?key=$key&q=$city";

    var responce = await _dio.get(path);

    return responce;
  }
}
