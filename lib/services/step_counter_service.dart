import 'package:health/health.dart';

HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);
void countSteps() async {
  // create a HealthFactory for use in the app, choose if HealthConnect should be used or not

  // define the types to get
  var types = [
    HealthDataType.STEPS,
    HealthDataType.BLOOD_GLUCOSE,
  ];

  // requesting access to the data types before reading them
  bool requested = await health.requestAuthorization(types);

  var now = DateTime.now();

  // fetch health data from the last 24 hours
  List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
      now.subtract(Duration(days: 1)), now, types);

  // request permissions to write steps and blood glucose
  types = [HealthDataType.STEPS, HealthDataType.BLOOD_GLUCOSE];
  var permissions = [HealthDataAccess.READ_WRITE, HealthDataAccess.READ_WRITE];
  await health.requestAuthorization(types, permissions: permissions);

  // write steps and blood glucose
  bool success =
      await health.writeHealthData(10, HealthDataType.STEPS, now, now);
  success =
      await health.writeHealthData(3.1, HealthDataType.BLOOD_GLUCOSE, now, now);

  // get the number of steps for today

  int? steps = await health.getTotalStepsInInterval(
      DateTime.now().subtract(const Duration(days: 2)), DateTime.now());
  print('Steps: $steps');
  print('Steps' + healthData.first.unit.name);
}

Future<int> fetchStepData(DateTime startTime, DateTime endTime) async {
  int? steps;
  bool stepsPermission = await health.hasPermissions([
        HealthDataType.STEPS,
        HealthDataType.BODY_FAT_PERCENTAGE,
        HealthDataType.SLEEP_SESSION,
        HealthDataType.WEIGHT,
        HealthDataType.WORKOUT
      ]) ??
      false;
  if (!stepsPermission) {
    stepsPermission = await health.requestAuthorization([
      HealthDataType.STEPS,
      HealthDataType.BODY_FAT_PERCENTAGE,
      HealthDataType.SLEEP_SESSION,
      HealthDataType.WEIGHT,
      HealthDataType.WORKOUT
    ]);
  }

  if (stepsPermission) {
    try {
      steps = await health.getTotalStepsInInterval(startTime, endTime);
      // print(weight.first.value);
    } catch (error) {
      print("Caught exception in getTotalStepsInInterval: $error");
    }

    return steps ?? 0;
  } else {
    print("Authorization not granted - error in authorization");
    return 0;
  }
}
