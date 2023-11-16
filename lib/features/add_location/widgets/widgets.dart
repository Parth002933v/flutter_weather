import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_weather/common/utils/constants.dart';
import 'package:flutter_weather/common/widgets/text_widget.dart';
import 'package:flutter_weather/features/add_location/model/search_city_model.dart';
import 'package:flutter_weather/features/add_location/provider/featch_weather_data_provider.dart';
import 'package:flutter_weather/features/add_location/provider/on_city_add_provider.dart';
import 'package:flutter_weather/features/add_location/provider/on_search_provider.dart';
import 'package:flutter_weather/features/home/widget/widget.dart';
import 'package:flutter_weather/global.dart';
import 'package:flutter_weather/main.dart';

class AllLocationAppBar extends ConsumerWidget {
  const AllLocationAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBarContent = ref.watch(appBarContentProvider);
    final appBarContentN = ref.watch(appBarContentProvider.notifier);
    final onSearchKeyWordP = ref.read(onSearchKeyWordProvider.notifier);
    if (appBarContent.isSearch) {
      return Container(
        margin: EdgeInsets.only(right: 30.w),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                appBarContentN.onSearch();
                onSearchKeyWordP.update((state) => "");
              },
              icon: const Icon(
                Icons.arrow_back_sharp,
                size: 25,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: TextFormField(
                onChanged: (value) {
                  onSearchKeyWordP.update((state) => value);
                },
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Search City",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  navkey.currentState!.pop();
                },
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
              ),
              const Text16normal(
                text: "Saved Location",
                fontWeight: FontWeight.bold,
                shadow: false,
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              ref.read(appBarContentProvider.notifier).onSearch();
            },
            icon: const RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
      );
    }
  }
}

class SavedLocationList extends ConsumerWidget {
  const SavedLocationList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = ref.watch(onSearchKeyWordProvider);

    final appBarContent = ref.watch(appBarContentProvider);

    final data = ref.watch(searchCityProvider(searchText));
    if (appBarContent.isSearch) {
      return onSeachCityCard(data, searchText, ref: ref);
    }
    return savedCitys();
  }

  Widget savedCitys() {
    final savedCity = Global.services.getSavedLocation();
    if (savedCity.isNotEmpty) {
      print("savedCity is not empty $savedCity");
      return Expanded(
        child: ListView.builder(
          itemCount: savedCity.length,
          itemBuilder: (context, index) =>
              LocationCard(city: savedCity[index].city),
        ),
      );
    } else {
      print("savedCity is $savedCity");
      return const Center(child: Text16normal(text: 'Try Adding new Location'));
    }
  }

  Container onSeachCityCard(
    AsyncValue<List<CityLocationModel>?> data,
    String searchText, {
    required WidgetRef ref,
  }) {
    final citySaveN = ref.read(citySaveProvider.notifier);
    return Container(
      child: data.when(
          data: (data) {
            if (data!.isNotEmpty) {
              return Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        final citys = citySaveN.onNewCityAdd(SavedCityModel(
                            city: data[index].name,
                            country: data[index].country));

                        print('on tap : $citys');
                        await Global.services
                            .setString(AppConstants.CITY_KEY, citys);
                      },
                      child: LocationCard(
                          city: data[index].name, showcountry: true),
                    );
                  },
                ),
              );
            } else {
              return const Center(child: Text("No City Found"));
            }
          },
          error: (error, stackTrace) => Container(),
          loading: () => searchText == ""
              ? const Expanded(child: Center(child: Text("Search City")))
              : const CircularProgressIndicator()),
    );
  }
}

class LocationCard extends ConsumerWidget {
  final String city;
  final bool showcountry;

  const LocationCard({super.key, required this.city, this.showcountry = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(fetchWeatherDataInSavedCardProvider(city));

    return Container(
      height: 170.h,
      width: 370.w,
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: data.when(
        data: (data) {
          print('The Location card data is : ${data != null}');
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showcountry) Text12normal(text: data!.location.country),
                  SizedBox(
                    width: 250.w,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text20normal(
                        text: data!.location.name,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text16normal(
                    text: data.current.condition.text,
                    shadow: false,
                    fontWeight: FontWeight.w500,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Text14normal(
                        text: 'Humidity ',
                        shadow: false,
                      ),
                      Text14normal(
                        text: "${data.current.humidity.toString()}%",
                        shadow: false,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text14normal(
                        text: 'Wind ',
                        shadow: false,
                      ),
                      Text14normal(
                        text: '${data.current.windKph.toString()}km/h',
                        shadow: false,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // LottieBuilder.asset(
                  //   'assets/animate_logo/1063.json',
                  //   height: 40.h,
                  // ),
                  weatherIndicateLogo(
                    conditionCode: data.current.condition.code,
                    isDay: data.current.isDay,
                    height: 50,
                    width: 50,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text40bold(text: data.current.tempC.toInt().toString()),
                      const Text20normal(
                          text: '°C', fontWeight: FontWeight.bold),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          return const Center();
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
          // : Center(child: Text20normal(text: "No Weather Found"));
        },
      ),
    );
  }
}

InkWell addNewLocationCard({
  required BuildContext context,
  required WidgetRef ref,
}) {
  return InkWell(
    borderRadius: const BorderRadius.all(Radius.circular(20)),
    onTap: () {
      // showDialog(
      //   context: context,
      //   builder: (ctx) {
      //     return AlertDialog(
      //       // backgroundColor: Colors.white.withOpacity(0.5),
      //       title: const Center(child: Text('Enter The City')),
      //       content: Container(
      //         height: 50.h,
      //         width: 200.w,
      //         child: Column(
      //           // mainAxisAlignment: MainAxisAlignment.center,
      //           // crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             TextFormField(
      //               onChanged: (value) {},
      //               keyboardType: TextInputType.text,
      //               maxLines: 1,
      //               decoration:
      //                   const InputDecoration(hintText: 'Enter The City'),
      //             ),
      //           ],
      //         ),
      //       ),
      //
      //       actions: [
      //         TextButton(
      //           onPressed: () async {},
      //           child: const Text('Get City'),
      //         )
      //       ],
      //     );
      //   },
      // );
    },
    child: Container(
      height: 70.h,
      width: 370.w,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add_circle_outline_outlined, color: Colors.white),
          SizedBox(width: 10.w),
          const Text20normal(
            text: 'Add New',
            fontWeight: FontWeight.bold,
            shadow: false,
          )
        ],
      ),
    ),
  );
}
