import 'package:ontrack/data/modals/user_model.dart';

class AppConstants {
  static const String bgImage = "assets/images/background.png";
  static const List<String> daysOfWeekFull = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
}

int getDayNuumberOfWeek(String day) {
  if (day == 'Sunday') {
    return 0;
  } else if (day == 'Monday') {
    return 1;
  } else if (day == 'Tuesday') {
    return 2;
  } else if (day == 'Wednesday') {
    return 3;
  } else if (day == 'Thursday') {
    return 4;
  } else if (day == 'Friday') {
    return 5;
  } else {
    return 6;
  }
}

String getDayName(String abb) {
  if (abb == "Su") {
    return "Sunday";
  } else if (abb == "M") {
    return "Monday";
  } else if (abb == "T") {
    return "Tuesday";
  } else if (abb == "W") {
    return "Wednesday";
  } else if (abb == "Th") {
    return "Thursday";
  } else if (abb == "F") {
    return "Friday";
  } else {
    return "Saturday";
  }
}

User? user = null;
