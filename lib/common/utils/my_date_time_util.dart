import 'package:date_format/date_format.dart';

class MyDateUtils {
  static getMonthDate(String dateTime) {
    final getDate = DateTime.parse(dateTime);

    return formatDate(getDate, [MM, " ", dd]);
  }

  static getWeekDate(String dateTime) {
    final getDate = DateTime.parse(dateTime);

    return formatDate(getDate, [D, " ", dd]);
  }

  static getDateTime(String dateTime) {
    final getDate = DateTime.parse(dateTime);

    return formatDate(
        getDate, [dd, "/", mm, "/", yyyy, " ", h, ":", nn, " ", am]);
  }
}
