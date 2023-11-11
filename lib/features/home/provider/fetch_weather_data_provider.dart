import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/common/model/weather_model.dart';
import 'package:flutter_weather/common/service/http_util.dart';
import 'package:flutter_weather/common/service/weather_ervice.dart';

final fetchWeatherDataProvider = StreamProvider((ref) async* {
  try {
    final city = await WeatherService.getCurrentLocationCity();

    final responce = await HttpUtil().get(city);

    if (responce.statusCode == 200) {
      yield WeatherModel.fromJson(responce.data);
    }
  } catch (e) {
    // Handle errors
    log('Error: $e');
  }
});
