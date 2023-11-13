import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/common/model/weather_model.dart';
import 'package:flutter_weather/common/service/http_util.dart';

final fetchWeatherDataInSavedCardProvider =
    StreamProvider.family<WeatherModel?, String>((ref, city) async* {
  try {
    final responce = await HttpUtil().get(city);

    if (responce.statusCode == 200) {
      yield WeatherModel.fromJson(responce.data);
    } else {
      yield null;
    }
  } catch (e) {
    // Handle errors
    log('Error: $e');
  }
});
