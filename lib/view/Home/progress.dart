import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ontrack/utils/color_resources.dart';
import 'package:ontrack/view/charts/bar_chart.dart';
import 'package:ontrack/view/charts/line_chart.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Progress extends StatefulWidget {
  const Progress({Key? key}) : super(key: key);

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const ListTile(
                  title: Text(
                    'Progress',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Sofia you can easily track your progress',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/background.png'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ToggleSwitch(
                  activeBgColor: [ColorResources.gradientColor],
                  inactiveBgColor: Color(0xff191919),
                  inactiveFgColor: Colors.white,
                  minHeight: 40,
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  centerText: true,
                  initialLabelIndex: 0,
                  totalSwitches: 4,
                  labels: [
                    'Past Week',
                    'Past 1mth',
                    'Past 6mths',
                    'Past 12mths'
                  ],
                  onToggle: (index) {
                    print('switched to: $index');
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                //   FlChartSample1(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton(
                        underline: SizedBox(),
                        dropdownColor: ColorResources.primaryColor,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: ColorResources.primaryColor,
                        ),
                        style: TextStyle(color: Colors.white),
                        items: [
                          DropdownMenuItem(child: Text('Steps')),
                        ],
                        onChanged: (value) {},
                      ),
                      DropdownButton(
                        underline: SizedBox(),
                        dropdownColor: ColorResources.primaryColor,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: ColorResources.primaryColor,
                        ),
                        style: TextStyle(color: Colors.white),
                        items: [
                          DropdownMenuItem(child: Text('Compare')),
                        ],
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
                DataLineChart(),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: DropdownButton(
                      alignment: Alignment.topLeft,
                      underline: SizedBox(),
                      dropdownColor: ColorResources.primaryColor,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: ColorResources.primaryColor,
                      ),
                      style: TextStyle(color: Colors.white),
                      items: [
                        DropdownMenuItem(child: Text('Strength')),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
