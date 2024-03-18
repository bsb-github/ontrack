import 'package:health/health.dart';

class BodyDataService {
  HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);
  Future<List<Map<String, List<HealthDataPoint>>>> getBodyData(
      int noOfDays) async {
    var types = [
      HealthDataType.BODY_FAT_PERCENTAGE,
      HealthDataType.BODY_MASS_INDEX,
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.WEIGHT,
    ];
    var now = DateTime.now();
    var startDate = DateTime(now.year, now.month, now.day - noOfDays);
    var endDate = DateTime(now.year, now.month, now.day);

    List<Map<String, List<HealthDataPoint>>> bodyData = [];

    for (var i = 0; i < noOfDays; i++) {
      var date = startDate.add(Duration(days: i));
      var data = await health.getHealthDataFromTypes(
          date, date.subtract(Duration(hours: 23)), types);
      bodyData.add({date.toString(): data});
    }

    return bodyData;
  }
}
