import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/features/add_location/model/all_location_state.dart';

class AppBarContentNotifier extends StateNotifier<AppBarContentModel> {
  AppBarContentNotifier() : super(AppBarContentModel());

  void onSearch() {
    state = state.copyWith(isSearch: !state.isSearch);
  }

  bool checkBool() {
    if (state.isSearch) {
      return true;
    } else {
      return false;
    }
  }
}

final appBarContentProvider =
    StateNotifierProvider<AppBarContentNotifier, AppBarContentModel>((ref) {
  return AppBarContentNotifier();
});


///-----------------------------------------------------------------------------
final onSearchKeyWordProvider = StateProvider<String>((ref) {
  return '';
});
