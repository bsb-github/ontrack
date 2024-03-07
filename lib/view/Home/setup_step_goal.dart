import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ontrack/utils/color_resources.dart';

class SetupStepGoal extends StatefulWidget {
  const SetupStepGoal({super.key});

  @override
  State<SetupStepGoal> createState() => _SetupStepGoalState();
}

class _SetupStepGoalState extends State<SetupStepGoal> {
  final List<String> daysOfWeek = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 30,
                    )),
                Expanded(
                    flex: 9,
                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      shrinkWrap: true,
                      children: [
                        Text(
                          'Setup Step Goal',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Sofia you can easily track your progress',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: daysOfWeek.asMap().entries.map((entry) {
                            return Expanded(
                              child: Consumer(builder: (context, ref, child) {
                                return CustomCheck(
                                  day: entry.value,
                                  index: entry.key,
                                );
                              }),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Consumer(builder: (context, ref, child) {
                              return Transform.scale(
                                scale: 1.5,
                                child: Checkbox(
                                  value: ref
                                      .watch(checkboxProvider)
                                      .every((e) => e),
                                  shape: CircleBorder(),
                                  onChanged: (value) {
                                    ref
                                        .read(checkboxProvider.notifier)
                                        .toggleAll();
                                  },
                                  activeColor: Colors.green,
                                ),
                              );
                            }),
                            Text(
                              'Select all Days',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          child: Card(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Color.fromARGB(255, 72, 72, 72),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.0,
                                vertical: 2.0,
                              ),
                              child: ExpansionTile(
                                iconColor: Color.fromARGB(255, 174, 174, 174),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                collapsedIconColor:
                                    Color.fromARGB(255, 174, 174, 174),
                                backgroundColor: Colors.black,
                                title: Text(
                                  'Set Step',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 2,
                                    ),
                                    child: SecondaryTabbar(
                                        onTabSelected: (index) {}),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.0,
                                      vertical: 17.0,
                                    ),
                                    width: double.infinity,
                                    child: Card(
                                      color: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 74, 73, 73),
                                          width: 1,
                                        ),
                                      ),
                                      child: const ExpansionTile(
                                        iconColor:
                                            Color.fromARGB(255, 174, 174, 174),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        collapsedIconColor:
                                            Color.fromARGB(255, 174, 174, 174),
                                        backgroundColor: Colors.black,
                                        title: Text(
                                          '9',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        children: <Widget>[
                                          ListTile(
                                            title: Text(
                                              'Child 1',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Display",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 186, 179, 179)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Card(
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        color: Color.fromARGB(255, 72, 72, 72),
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.signal_cellular_4_bar,
                                            color: Colors.white),
                                        Text(
                                          "Bar",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Card(
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        color: Color.fromARGB(255, 72, 72, 72),
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.signal_cellular_4_bar,
                                            color: Colors.white),
                                        Text(
                                          "Bar",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Card(
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        color: Color.fromARGB(255, 72, 72, 72),
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.signal_cellular_4_bar,
                                            color: Colors.white),
                                        Text(
                                          "Bar",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CheckboxNotifier extends StateNotifier<List<bool>> {
  CheckboxNotifier() : super(List<bool>.filled(7, false));

  void toggle(int index) {
    state = List.from(state)..[index] = !state[index];
  }

  void toggleAll() {
    state = List.from(state)..fillRange(0, 7, !state[0]);
  }
}

final checkboxProvider =
    StateNotifierProvider<CheckboxNotifier, List<bool>>((ref) {
  return CheckboxNotifier();
});

class CustomCheck extends ConsumerWidget {
  final String day;
  final int index;

  CustomCheck({Key? key, required this.day, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = ref.watch(checkboxProvider)[index];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(79, 47, 105, 152)),
      child: Column(
        children: [
          Text(
            day,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Transform.scale(
            scale: 1.3,
            child: Checkbox(
              value: isChecked,
              shape: CircleBorder(),
              onChanged: (value) {
                ref.read(checkboxProvider.notifier).toggle(index);
              },
              activeColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class SecondaryTabbar extends ConsumerWidget {
  final ValueChanged<int> onTabSelected;

  const SecondaryTabbar({Key? key, required this.onTabSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    void _onTabTapped(int index) {
      ref.read(selectedIndexProvider.notifier).state = index;
      onTabSelected(index);
    }

    Widget _buildTab(String title, int index) {
      return Expanded(
        child: GestureDetector(
          onTap: () => _onTabTapped(index),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: selectedIndex == index
                  ? const Color(0xFF00BAAB)
                  : Colors.transparent,
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: selectedIndex == index ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget verticalDivider() {
      return VerticalDivider(
        width: 0,
        thickness: 0,
        indent: 8,
        endIndent: 8,
        color: Colors.grey,
      );
    }

    return Container(
      height: 30,
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF292929),
      ),
      child: Row(
        children: [
          _buildTab('Greater then', 0),
          verticalDivider(),
          _buildTab('Less then', 1),
          verticalDivider(),
          _buildTab('Between', 2),
        ],
      ),
    );
  }
}
