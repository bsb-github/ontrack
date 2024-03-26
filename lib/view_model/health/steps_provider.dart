import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ontrack/services/step_counter_service.dart';
import 'package:ontrack/utils/app_contants.dart';

class StepsProvider extends StateNotifier<List<Map<String, String>>> {
  StepsProvider() : super([]);

  Future<void> getStepsFor7day() async {
    state.clear();
    // var today = DateFormat('EEEE').format(DateTime.now());
    // var numberOfday = getDayNuumberOfWeek(today);
    DateTime start = DateTime.now();
    int i = 0;
    int steps = 0;

    do {
      print(start.day);
      var midnight = DateTime(start.year, start.month, start.day);
      steps = await fetchStepData(midnight, start);

      state.add({
        'day': DateFormat('EEEE').format(start),
        'steps': steps.toString(),
      });
      print('Day: ${state[i]['day']} Steps: ${state[i]['steps']}');
      start = start.subtract(Duration(days: 1));
      i++;
      print(DateFormat('EEEE').format(start));
    } while (start.weekday != DateTime.saturday);
    for (var i = 0; i < AppConstants.daysOfWeekFull.length; i++) {
      if (state.any((element) =>
          element['day']!.toLowerCase() ==
          AppConstants.daysOfWeekFull[i].toLowerCase())) {
        continue;
      } else {
        state.add({
          'day': AppConstants.daysOfWeekFull[i],
          'steps': '0',
        });
      }
    }
    print("llllll ${state.length}");
  }
}
