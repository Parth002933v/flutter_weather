import 'package:dio/dio.dart';
import 'package:flutter_weather/common/model/weather_model.dart';
import 'package:flutter_weather/common/utils/constants.dart';

class HttpUtil {
  late Dio dio;

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

    dio = Dio(options);
  }

  Future<Response> get(String city) async {
    const key = AppConstants.SERVER_API_KEY;

    final path = "/forecast.json?key=$key&q=$city";

    var responce = await dio.get(path);

    return responce;
  }
}
