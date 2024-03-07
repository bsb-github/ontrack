import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ontrack/utils/color_resources.dart';
import 'package:ontrack/utils/common_button.dart';
import 'package:ontrack/view/Home/add_new_goal.dart';

class Plan extends ConsumerStatefulWidget {
  const Plan({super.key});

  @override
  ConsumerState<Plan> createState() => _SetupBioState();
}

class _SetupBioState extends ConsumerState<Plan> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
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
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      title: Text(
                        'My Plan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Healthy Habits make a healthy people',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/images/background.png'),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Color.fromARGB(143, 51, 91, 124),
                      child: Theme(
                        data: ThemeData(
                          unselectedWidgetColor: Colors.white,
                        ),
                        child: ExpansionTile(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          leading: Image.asset(
                            'assets/images/background.png',
                            height: 40,
                          ),
                          title: Text(
                            'Get fit for summer',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          subtitle: Text(
                            'Goal: 14% body fat',
                            style: TextStyle(
                              color: Color.fromARGB(255, 240, 228, 228),
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 36,
                                vertical: 18,
                              ),
                              child: LinearProgressIndicator(
                                minHeight: 8,
                                backgroundColor:
                                    Color.fromARGB(255, 25, 74, 114),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color.fromARGB(255, 14, 134, 18),
                                ),
                                value: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomButton('Gym', '3x in a week'),
                    CustomButton('Sleep', "8hrs a day"),
                    CustomButton('Calories', "2000 Calories in a week"),
                    CustomButton('Protein', '130g Protein in a day'),
                    CustomButton('Weight Loss', "10k steps a day"),
                    CustomButton('Muscle Mass', '200g week'),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: CommonButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AddNewFoal();
                      }));
                    },
                    text: "Add New Goal"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CustomButton(String goal, String subtitle) {
    return Container(
      height: 80,
      child: Consumer(
        builder: (context, ref, child) {
          return Card(
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
          );
        },
      ),
    );
  }
}
