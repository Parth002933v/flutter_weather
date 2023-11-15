import 'package:flutter_riverpod/flutter_riverpod.dart';

class CitySaveNotifier extends StateNotifier<List<SavedCityModel>> {
  CitySaveNotifier() : super([]);

  onNewCityAdd(SavedCityModel savedCityModel) {
    // if provider has data
    if (state.contains(savedCityModel)) {
      state = state
          .where((state) =>
              (state.city != savedCityModel.city) &&
              (state.country != savedCityModel.country))
          .toList();

      print("the lenth is ${state.length}");
    } else {
      state = [...state, savedCityModel];
      print("the lenth is ${state.length}");
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
}
