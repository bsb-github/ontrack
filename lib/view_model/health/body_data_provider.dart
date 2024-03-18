import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';
import 'package:ontrack/services/body_data_service.dart';

class BodyDataProvider
    extends StateNotifier<List<Map<String, List<HealthDataPoint>>>> {
  BodyDataProvider() : super([]);

  void getBodyData(int noOfDays) async {
    state.clear();
    state = await BodyDataService().getBodyData(noOfDays);
    print(state.length);
    print(state[0].keys.toList()[0]);
  }
}
