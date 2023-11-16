import 'dart:convert';

import 'package:flutter_weather/common/utils/constants.dart';
import 'package:flutter_weather/features/add_location/provider/on_city_add_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServices {
  late final SharedPreferences _preferences;

  Future<StorageServices> init() async {
    _preferences = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  List<SavedCityModel> getSavedLocation() {
    // String stringList = _preferences.getString(AppConstants.CITY_KEY) ?? '';
    // final jsonString = jsonDecode(stringList);
    // final cityMapList = jsonString.map((city) => city.toJson()).toList();
    String? jsonString = _preferences.getString(AppConstants.CITY_KEY);
    if (jsonString != null) {
      // Convert the JSON string back to a List<Map<String, dynamic>>
      List<dynamic> cityMapList = jsonDecode(jsonString);

      // Convert the List<Map<String, dynamic>> to a List<SavedCityModel>
      List<SavedCityModel> cityList =
          cityMapList.map((item) => SavedCityModel.fromJson(item)).toList();
      return cityList;
    } else {
      // Return an empty list if no data is found
      return [];
    }
  }
}
