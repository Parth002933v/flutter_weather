import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_weather/common/model/weather_model.dart';
import 'package:flutter_weather/common/utils/enums.dart';
import 'package:flutter_weather/common/utils/my_date_time_util.dart';
import 'package:flutter_weather/common/widgets/text_widget.dart';
import 'package:flutter_weather/main.dart';
import 'package:lottie/lottie.dart';

Container weatherRoutine({required String date, required Day day}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text16normal(text: '${MyDateUtils.getWeekDate(date)}'),
        // LottieBuilder.asset('assets/animate_logo/1063.json', height: 40.h),
        weatherIndicateLogo(
          conditionCode: day.condition.code,
          isDay: 1,
          height: 55.h,
          width: 55.w,
        ),
        Text16normal(text: '${day.avgtempC.toInt()}°'),
        // const Text12normal(text: '1-5\nkm/h'),
        Text12normal(text: '${day.maxwindKph}\nkm/h'),
      ],
    ),
  );
}

Container fullDayStatus({required List<Forecastday> forecastday}) {
  return Container(
    height: 160.h,
    width: 370.w,
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
    decoration: BoxDecoration(
      color: Colors.grey.shade700.withOpacity(0.7),
      borderRadius: const BorderRadius.all(Radius.circular(30)),
    ),
    child: ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: [
        weatherRoutine(date: forecastday[0].date, day: forecastday[0].day),
        weatherRoutine(date: forecastday[1].date, day: forecastday[1].day),
        weatherRoutine(date: forecastday[2].date, day: forecastday[2].day),
        weatherRoutine(date: forecastday[2].date, day: forecastday[2].day),
      ],
    ),
  );
}

Row atmosphereStatus(
    {required String humidity,
    required String wind,
    required String feelsLike}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      atmosphereStatusContainor(
        text: 'HUMIDITY',
        status: "$humidity%",
        icon: Icons.water_drop_outlined,
      ),
      atmosphereStatusContainor(
        text: 'WIND',
        status: "${wind}km/h",
        icon: Icons.air,
      ),
      atmosphereStatusContainor(
        text: 'FEELS LIKE',
        status: "$feelsLike°",
        icon: Icons.thermostat,
      ),
    ],
  );
}

Column atmosphereStatusContainor(
    {required String text, required String status, required IconData icon}) {
  return Column(
    children: [
      Icon(
        icon,
        color: Colors.white,
        size: 35.spMin,
      ),
      Text14normal(
        text: text,
        fontWeight: FontWeight.bold,
      ),
      Text14normal(
        text: status,
        fontWeight: FontWeight.bold,
      )
    ],
  );
}

Row weatherTemperature({required double temperature}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text80bold(
          text: temperature.toInt().toString(), fontWeight: FontWeight.w600),
      const Text30bold(text: '°C'),
    ],
  );
}

FittedBox currentWeatherCondition({required String condition}) => FittedBox(
      child: Text30bold(
        text: condition,
      ),
    );

LottieBuilder weatherIndicateLogo({
  required int conditionCode,
  required int isDay,
  double height = 100,
  double width = 100,
}) {
  if (codeList.contains(conditionCode)) {
    final getCodeLogo = codeList.where((code) => code == conditionCode).first;

    return LottieBuilder.asset(
      isDay == 1
          ? 'assets/animate_logo/day/$getCodeLogo.json'
          : 'assets/animate_logo/nigth/$getCodeLogo.json',
      height: height.h,
      width: width.w,
      fit: BoxFit.fill,
    );
  } else {
    return LottieBuilder.asset(
      'assets/animate_logo/3.json',
      height: height,
    );
  }
}

Column currentTime({required String dateTime}) {
  return Column(
    children: [
      Text30bold(text: MyDateUtils.getMonthDate(dateTime).toString()),
      Text14normal(text: 'Updated ${MyDateUtils.getDateTime(dateTime)}'),
    ],
  );
}

Row homeAppBar({
  required String CountryLlocation,
  required String cityLocation,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Icon(Icons.location_pin, size: 30.spMin, color: Colors.white),
          Text16normal(
            text: "$cityLocation, $CountryLlocation",
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
      IconButton(
        onPressed: () {
          navkey.currentState!.pushNamed(RoutesConstant.SavedLocation);
        },
        icon: Icon(Icons.menu, size: 30.spMin, color: Colors.white),
      )
    ],
  );
}
