import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CitySaveNotifier extends StateNotifier<List<SavedCityModel>> {
  CitySaveNotifier() : super([]);

  String onNewCityAdd(SavedCityModel savedCityModel) {
    // if provider has data
    if (state.contains(savedCityModel)) {
      state = state
          .where((state) =>
              (state.city != savedCityModel.city) &&
              (state.country != savedCityModel.country))
          .toList();

      final cityMapList = state.map((city) => city.toJson()).toList();

      String jsonString = jsonEncode(cityMapList);
      print(jsonString);

      return jsonString;
    } else {
      state = [...state, savedCityModel];
      // final jsonState = state.map((state) => jsonEncode(state)).toList();
        final cityMapList = state.map((city) => city.toJson()).toList();

      String jsonString = jsonEncode(cityMapList);

      print(jsonString);
      return jsonString;
    }
  }
}

final citySaveProvider =
    StateNotifierProvider<CitySaveNotifier, List<SavedCityModel>>(
        (ref) => CitySaveNotifier());

class SavedCityModel {
  final String city;
  final String country;

  SavedCityModel({required this.city, required this.country});

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'country': country,
    };
  }

  factory SavedCityModel.fromJson(Map<String, dynamic> json) {
    return SavedCityModel(
      city: json['city'],
      country: json['country'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedCityModel &&
          runtimeType == other.runtimeType &&
          city == other.city &&
          country == other.country;

  @override
  int get hashCode => city.hashCode ^ country.hashCode;
}
