import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ontrack/data/modals/goal_modal.dart';
import 'package:ontrack/data/repository/user_repo.dart';
import 'package:ontrack/utils/app_contants.dart';
import 'package:ontrack/utils/common_button.dart';
import 'package:ontrack/view/Home/Home.dart';
import 'package:ontrack/view/Home/home_page_collapse.dart';
import 'package:ontrack/view/onboarding/onboarding_n.dart';
import 'package:shared_preferences/shared_preferences.dart';

final goalSelectionProvider =
    StateNotifierProvider<GoalSelectionNotifier, String>((ref) {
  return GoalSelectionNotifier();
});

class GoalSelectionNotifier extends StateNotifier<String> {
  GoalSelectionNotifier() : super('');

  void selectGoal(String goal) {
    state = goal;
  }
}

class SelectFirstGoal extends ConsumerStatefulWidget {
  const SelectFirstGoal({super.key});

  @override
  ConsumerState<SelectFirstGoal> createState() => _SetupBioState();
}

class _SetupBioState extends ConsumerState<SelectFirstGoal> {
  var loading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: ListView(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Select Your First Goal',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 7),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Recommended are based on your goal',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Recommended based on your goal',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                  SizedBox(height: 10),
                  // customRadio('Gym', '3x in a week'),
                  // customRadio('Protein', '130g Protein in a day'),
                  // customRadio('Muscle Mass', '200g week'),
                  ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var goal = goals[index];
                      return customRadio(goal);
                    },
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Choose other',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      var goal = goals[index + 3];
                      return customRadio(goal);
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CommonButton(
                onPressed: () async {
                  var fg = goals.where((element) =>
                      element.goalName == ref.read(goalSelectionProvider));
                  user!.goal = <Goal>[];
                  user!.goal!.add(fg.first);
                  print(user!.toJson());
                  EasyLoading.show();
                  var status = await UserRepo().registerDevice(user!);
                  if (status) {
                    print("success");
                    var pref = await SharedPreferences.getInstance();
                    pref.setBool('isFirstTime', true);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePageCollapse(),
                        ));
                  }

                  // ref.read(pageProvider.notifier).setPage(4);
                },
                text: "Next"),
          ),
        ],
      ),
    );
  }

  Widget customRadio(Goal goal) {
    var list = goal.goalName!.split(' ');
    var iconName = list.first.toLowerCase();
    return Consumer(
      builder: (context, ref, child) {
        final selectedGoal = ref.watch(goalSelectionProvider);
        return Container(
          height: 80,
          width: double.infinity,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Color.fromARGB(143, 51, 91, 124),
            child: ListTile(
              contentPadding:
                  EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 10),
              leading: Image.asset(
                'assets/images/$iconName.png',
                height: 40,
              ),
              title: Text(
                goal.goalName!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              subtitle: Text(
                goal.goalSubtile!,
                style: TextStyle(
                  color: Color.fromARGB(255, 240, 228, 228),
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: Theme(
                data: ThemeData(useMaterial3: true),
                child: RadioTheme(
                  data: RadioThemeData(
                    fillColor: MaterialStateProperty.resolveWith(
                      (states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.green;
                        }
                        return Colors.white;
                      },
                    ),
                  ),
                  child: Radio(
                    value: goal.goalName,
                    groupValue: selectedGoal,
                    onChanged: (value) => ref
                        .read(goalSelectionProvider.notifier)
                        .selectGoal(value.toString()),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
