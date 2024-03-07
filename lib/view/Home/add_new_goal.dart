import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ontrack/utils/color_resources.dart';

class AddNewFoal extends StatefulWidget {
  static const String routeName = 'onboarding';

  const AddNewFoal({Key? key}) : super(key: key);

  @override
  _AddNewFoalState createState() => _AddNewFoalState();
}

class _AddNewFoalState extends State<AddNewFoal> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            CupertinoIcons.xmark,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Add New Goal',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'View available goals from Connected devices',
                              style: TextStyle(
                                color: Color.fromARGB(255, 182, 182, 193),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              Consumer(builder: (context, ref, child) {
                                return SecondaryTabbar(onTabSelected: (index) {
                                  ref
                                      .read(selectedIndexProvider.notifier)
                                      .state = index;
                                });
                              }),
                              Consumer(builder: (context, ref, child) {
                                return IndexedStack(
                                  index: ref.watch(selectedIndexProvider),
                                  children: [
                                    ListView(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: [
                                        CustomButton('goal', 'subtitle1'),
                                        CustomButton('goal', 'subtitle1'),
                                      ],
                                    ),
                                    ListView(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: [
                                        CustomButton('goal', 'subtitle2'),
                                        CustomButton('goal', 'subtitle2'),
                                      ],
                                    ),
                                    ListView(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      children: [
                                        CustomButton('goal', 'subtitle3'),
                                        CustomButton('goal', 'subtitle3'),
                                      ],
                                    ),
                                    ListView(
                                      physics: NeverScrollableScrollPhysics(),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      shrinkWrap: true,
                                      children: [
                                        CustomButton('goal', 'subtitl4'),
                                        CustomButton('goal', 'subtitle4'),
                                      ],
                                    ),
                                  ],
                                );
                              }),
                            ],
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
      ),
    );
  }

  Widget CustomButton(String goal, String subtitle) {
    return Consumer(
      builder: (context, ref, child) {
        return Container(
          height: 80,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Color.fromARGB(143, 51, 91, 124),
            child: ListTile(
              contentPadding:
                  EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 10),
              leading: Image.asset(
                'assets/images/background.png',
                height: 40,
              ),
              title: Text(
                goal,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                ),
              ),
              subtitle: Text(
                subtitle,
                style: TextStyle(
                  color: Color.fromARGB(255, 240, 228, 228),
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: Theme(
                data: ThemeData(
                  useMaterial3: true,
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      color: Color.fromARGB(255, 69, 139, 219),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(79, 33, 131, 170),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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

    return Container(
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF292929),
      ),
      child: Row(
        children: [
          _buildTab('Exercise', 0),
          _buildTab('Nutrition', 1),
          _buildTab('Wellbeing', 2),
          _buildTab('Body Comp', 3),
        ],
      ),
    );
  }
}
