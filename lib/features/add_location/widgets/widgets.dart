import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_weather/common/widgets/text_widget.dart';
import 'package:flutter_weather/features/add_location/provider/featch_weather_data_provider.dart';
import 'package:flutter_weather/features/home/widget/widget.dart';
import 'package:flutter_weather/main.dart';

Row appBar() {
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
        onPressed: () {},
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

Expanded savedLocationList() {
  return Expanded(
    child: ListView(
      shrinkWrap: true,
      children: const [
        LocationCard(city: 'London'),
        LocationCard(city: 'Rome'),
        LocationCard(city: 'New York'),
        LocationCard(city: 'Beijing'),


      ],
    ),
  );
}

class LocationCard extends ConsumerWidget {
  final String city;

  const LocationCard({super.key, required this.city});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(fetchWeatherDataInSavedCardProvider(city));

    return Container(
      height: 160.h,
      width: 370.w,
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: data.when(
        data: (data) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text20normal(
                    text: data.location.name,
                    fontWeight: FontWeight.bold,
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
          log(error.toString());
          return Center(child: Text(error.toString()));
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

Container addNewLocationCard() {
  return Container(
    height: 70.h,
    width: 370.w,
    margin: EdgeInsets.only(bottom: 10.h),
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
  );
}
