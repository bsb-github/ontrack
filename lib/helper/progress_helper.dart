import 'package:ontrack/utils/app_contants.dart';

double getStepsForSpecificDay(
    List<Map<String, String>> steps, List dayOfWeek, int day, int currentDay) {
  var abb = getDayName(dayOfWeek[day]);
  print(abb);
  var data = steps.where((element) => element['day'] == abb).first;
  print(data["steps"]!);
  print(int.parse(data["steps"] ?? "0") / 10000);
  return (int.parse(data["steps"] ?? "0") / 10000);
}
