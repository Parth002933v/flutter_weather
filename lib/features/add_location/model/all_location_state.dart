class AppBarContentModel {
  // late final bool isSelected;
  late final bool isSearch;

  AppBarContentModel({
    // this.isSelected = false,
    this.isSearch = false,
  });

  AppBarContentModel copyWith({
    // bool? isSelected,
    bool? isSearch,
  }) {
    return AppBarContentModel(
      // isSelected: isSelected ?? this.isSelected,
      isSearch: isSearch ?? this.isSearch,
    );
  }
}
