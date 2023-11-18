import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/common/helper/helper.dart';
import 'package:flutter_weather/common/model/weather_model.dart';
import 'package:flutter_weather/common/service/http_util.dart';
import 'package:flutter_weather/features/add_location/model/search_city_model.dart';

final fetchWeatherDataInSavedCardProvider =
    StreamProvider.family<WeatherModel?, String>((ref, city) async* {
  try {
    final responce = await HttpUtil().getOne(city);

    if (responce.statusCode == 200) {
      yield WeatherModel.fromJson(responce.data);
    } else {
      yield null;
    }
  } on DioException catch (e) {
    Helper.showToastMessage(e.toString());
  } catch (e) {
    // Handle errors
    log('Error: $e');
    Helper.showToastMessage(e.toString());
  }
});

final searchCityProvider =
    StreamProvider.family<List<CityLocationModel>?, String>((ref, city) async* {
  try {
    final response = await HttpUtil().getCity(city);

    if (response.statusCode == 200) {
      print("the City Respose is : ${response.data}");
      final List<dynamic> responseData = response.data as List<dynamic>;
      final List<CityLocationModel> cityLocations =
          responseData.map((json) => CityLocationModel.fromJson(json)).toList();

      yield cityLocations;
    } else {
      yield null;
    }
  } on DioException catch (e) {
    Helper.showToastMessage(e.toString());
  } catch (e) {
    // Handle errors
    log('Error: $e');
    Helper.showToastMessage(e.toString());
  }
});
