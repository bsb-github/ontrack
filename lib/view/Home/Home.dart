import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:ontrack/data/modals/goal_modal.dart';
import 'package:ontrack/helper/progress_helper.dart';
import 'package:ontrack/utils/app_contants.dart';
import 'package:ontrack/utils/color_resources.dart';
import 'package:ontrack/view/goal/goal_info.dart';
import 'package:ontrack/view/profile/profile.dart';
import 'package:ontrack/view_model/health/steps_provider.dart';
import 'package:ontrack/view_model/user/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/modals/user_model.dart';
import '../../view_model/health/body_data_provider.dart';

const double paddingValue = 8.0;
const double avatarRadius = 20.0;
const double cardBorderRadius = 20.0;
const double progressIndicatorMinHeight = 8.0;
const double progressIndicatorValue = 0.5;
var stepProvider =
    StateNotifierProvider<StepsProvider, List<Map<String, String>>>((ref) {
  return StepsProvider();
});

final userProvider = StateNotifierProvider<UserProvider, User?>((ref) {
  return UserProvider();
});

var bodyDataProvider = StateNotifierProvider<BodyDataProvider,
    List<Map<String, List<HealthDataPoint>>>>((ref) {
  return BodyDataProvider();
});

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  bool loading = true;
  final List<String> daysOfWeek = ['Su', 'M', 'T', 'W', 'Th', 'F', 'S'];
  final List<Map<String, String>> dayNames = [
    {'dayLabel': 'Su', 'day': 'Sunday'},
    {'dayLabel': 'M', 'day': 'Monday'},
    {'dayLabel': 'T', 'day': 'Tuesday'},
    {'dayLabel': 'W', 'day': 'Wednesday'},
    {'dayLabel': 'Th', 'day': 'Thursday'},
    {'dayLabel': 'F', 'day': 'Friday'},
    {'dayLabel': 'S', 'day': 'Saturday'},
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    setState(() {});
  }

  void getData() async {
    var prefs = await SharedPreferences.getInstance();
    var device_id = prefs.getString('device_id');
    await ref.read(userProvider.notifier).getUserData(device_id!);
    await ref.watch(stepProvider.notifier).getStepsFor7day();
    Timer(Duration(seconds: 1), () {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentDay = DateTime.now().weekday - 1;

    print("1");
    print(currentDay);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: const [
            ColorResources.gradientColor,
            Colors.black,
            Colors.black,
            Colors.black,
          ],
        ),
      ),
      child: loading
          ? Center(
              child: CircularProgressIndicator(
              color: ColorResources.gradientColor,
            ))
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(paddingValue),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Home',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: InkWell(
                        onTap: () async {
                          print(ref
                              .read(stepProvider)
                              .where((element) =>
                                  element['day']!.toLowerCase() ==
                                  dayNames.first['day']!.toLowerCase())
                              .first['steps']);
                          var prefs = await SharedPreferences.getInstance();
                          var device_id = prefs.getString('device_id');
                          // print(dayNames.first['day']!.toLowerCase());
                          await ref
                              .read(userProvider.notifier)
                              .getUserData(device_id!);
                          print(ref.read(userProvider)!.goal!.first.goalName);
                          ref.read(stepProvider.notifier).getStepsFor7day();
                        },
                        child: Text(
                          'You can easily track your progress here',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      trailing: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Profile(),
                              ));
                        },
                        child: CircleAvatar(
                          radius: avatarRadius,
                          backgroundImage:
                              AssetImage('assets/images/background.png'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: dayNames.map((day) {
                        return Expanded(
                          child: Consumer(builder: (context, ref, child) {
                            print(day['day']!);

                            return DayOfWeekContainer(
                              day: day['dayLabel']! == 'Th'
                                  ? "T"
                                  : day['dayLabel']!,
                              progressIndicatorValue: int.parse(ref
                                          .watch(stepProvider)
                                          .where((element) =>
                                              element['day'] == day['day'])
                                          .isEmpty
                                      ? '0'
                                      : ref
                                          .watch(stepProvider)
                                          .where((element) =>
                                              element['day'] == day['day'])
                                          .first['steps']!) /
                                  10000,
                              date: DateTime.now().day +
                                  dayNames.indexOf(day) -
                                  currentDay -
                                  1,
                              isSelected:
                                  currentDay + 1 == dayNames.indexOf(day),
                            );
                          }),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: CardGrid(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class CardGrid extends StatelessWidget {
  const CardGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => GridView.builder(
        shrinkWrap: true,
        itemCount: ref.watch(userProvider)!.goal!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cardBorderRadius),
            ),
            color: Color.fromARGB(117, 31, 39, 100),
            child: CustomHomeWidget(
              () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoalInfo(
                        goal: ref.watch(userProvider)!.goal![index],
                      ),
                    ));
              },
              goal: ref.watch(userProvider)!.goal!.first,
              progressIndicatorValue: 0.5,
            ),
          );
        },
      ),
    );
  }
}

class CustomHomeWidget extends ConsumerWidget {
  final Goal goal;
  final double progressIndicatorValue;
  final VoidCallback onTap;
  CustomHomeWidget(
    this.onTap, {
    required this.goal,
    required this.progressIndicatorValue,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: paddingValue, vertical: 5.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: AssetImage('assets/images/daily_step.png'),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Text(
                      goal.goalName!.split(' ')[0] + "s",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      goal.goalSubtile!,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                int.parse(ref
                                .watch(stepProvider)
                                .where((element) =>
                                    element['day']!.toLowerCase() ==
                                    DateFormat('EEEE')
                                        .format(DateTime.now())
                                        .toLowerCase())
                                .first["steps"]!) /
                            int.parse(goal.goalValue!) >=
                        1
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorResources.green,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Completed",
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
                    : SizedBox(),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    ref
                        .watch(stepProvider)
                        .where((element) =>
                            element['day'] ==
                            DateFormat('EEEE').format(DateTime.now()))
                        .first["steps"]!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      minHeight: progressIndicatorMinHeight,
                      backgroundColor: Color.fromARGB(255, 25, 74, 114),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        (int.parse(ref
                                        .watch(stepProvider)
                                        .where((element) =>
                                            element['day'] ==
                                            DateFormat('EEEE')
                                                .format(DateTime.now()))
                                        .first["steps"]!) /
                                    int.parse(goal.goalValue!)) >
                                1
                            ? ColorResources.green
                            : Color.fromARGB(255, 201, 45, 115),
                      ),
                      value: (int.parse(ref
                              .watch(stepProvider)
                              .where((element) => element['day'] == 'Sunday')
                              .first["steps"]!) /
                          int.parse(goal.goalValue!)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: paddingValue),
                  child: Text(
                    "${((int.parse(ref.watch(stepProvider).where((element) => element['day'] == DateFormat('EEEE').format(DateTime.now())).first["steps"]!) / int.parse(goal.goalValue!)) * 100).toStringAsFixed(0)}%",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DayOfWeekContainer extends StatelessWidget {
  final String day;
  final int date;
  final double progressIndicatorValue;
  final bool isSelected;

  const DayOfWeekContainer(
      {Key? key,
      required this.day,
      required this.isSelected,
      required this.date,
      this.progressIndicatorValue = 0.1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected
              ? Color.fromARGB(79, 47, 105, 152)
              : Colors.transparent,
        ),
        child: Column(
          children: [
            Text(
              (day == 'Su') ? 'S' : day,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progressIndicatorValue,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      progressIndicatorValue >= 0.5
                          ? ColorResources.green
                          : progressIndicatorValue < 0.5 &&
                                  progressIndicatorValue > 0.25
                              ? Colors.yellow
                              : progressIndicatorValue < 0.25
                                  ? Colors.red
                                  : Colors.blue),
                  strokeWidth: 3.0,
                ),
                Text(
                  date.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
