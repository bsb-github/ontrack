import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ontrack/utils/color_resources.dart';
import 'package:ontrack/view/onboarding/tabs/setup_plain.dart';
import 'package:toggle_switch/toggle_switch.dart';

class EditPlan extends StatefulWidget {
  final String planTitle;
  final String planDescription;
  final String planMetricType;
  final num planMetricValue;
  const EditPlan(
      {super.key,
      required this.planTitle,
      required this.planDescription,
      required this.planMetricType,
      required this.planMetricValue});

  @override
  State<EditPlan> createState() => _EditPlanState();
}

class _EditPlanState extends State<EditPlan> {
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                const SizedBox(height: 20),
                Text(
                  'Set ${widget.planTitle} Plan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 40),
                Text("${widget.planMetricType} Consumed",
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
                const SizedBox(height: 20),
                TextFormField(
                  enabled: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(widget.planMetricType,
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    hintText: widget.planMetricValue.toString(),
                    hintStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.black,
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text("Every",
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
                const SizedBox(height: 20),
                ToggleSwitch(
                  activeBgColor: [ColorResources.gradientColor],
                  inactiveBgColor: Color(0xff191919),
                  inactiveFgColor: Colors.white,
                  minHeight: 40,
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  centerText: true,
                  initialLabelIndex: 0,
                  totalSwitches: 3,
                  labels: ['Day', 'Week', 'Month'],
                  onToggle: (index) {
                    print('switched to: $index');
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Lower Limit",
                            style: TextStyle(color: Colors.grey, fontSize: 16)),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          height: 50,
                          child: IncrementDecrementContainer(
                              text: "",
                              value: widget.planMetricValue.toString(),
                              onIncrement: () {},
                              onDecrement: () {}),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Upper Limit",
                            style: TextStyle(color: Colors.grey, fontSize: 16)),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          height: 50,
                          child: IncrementDecrementContainer(
                              text: "",
                              value: (widget.planMetricValue + 500).toString(),
                              onIncrement: () {},
                              onDecrement: () {}),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Text("Goal Alarm",
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
                const SizedBox(height: 10),
                CupertinoSwitch(value: true, onChanged: (val) {}),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Save Plan',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorResources.gradientColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(500),
                        ),
                      ),
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
