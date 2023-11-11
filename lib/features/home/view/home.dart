import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_weather/common/utils/constants.dart';
import 'package:flutter_weather/features/home/provider/fetch_weather_data_provider.dart';

import '../widget/widget.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(fetchWeatherDataProvider);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageConstants.BG1),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        body: SafeArea(
          child: data.when(
            data: (data) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    homeAppBar(
                      CountryLlocation: data.location.country,
                      cityLocation: data.location.name,
                    ),
                    SizedBox(height: 60.h),
                    currentTime(dateTime: data.current.lastUpdated),
                    SizedBox(height: 30.h),
                    weatherIndicateLogo(
                        conditionCode: data.current.condition.code,
                        isDay: data.current.isDay),
                    SizedBox(height: 20.h),
                    currentWeatherCondition(
                        condition: data.current.condition.text),
                    weatherTemperature(temperature: data.current.tempC),
                    SizedBox(height: 70.h),
                    atmosphereStatus(
                        humidity: data.current.humidity.toString(),
                      wind: data.current.windKph.toString(),
                      feelsLike: data.current.feelslikeC.toInt().toString(),
                    ),
                    SizedBox(height: 30.h),
                    fullDayStatus(),
                  ],
                ),
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
        ),
      ),
    );
  }
}
