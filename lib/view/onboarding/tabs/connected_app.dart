import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ontrack/utils/common_button.dart';
import 'package:ontrack/view/onboarding/onboarding_n.dart';

import 'package:ontrack/view_model/connected_app/connected_provider.dart';

class ConnectedApp extends ConsumerStatefulWidget {
  const ConnectedApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConnectedApp> createState() => _SetupBioState();
}

class _SetupBioState extends ConsumerState<ConnectedApp> {
  @override
  Widget build(BuildContext context) {
    final switchValues = ref.watch(switchProvider);
    final switchNotifier = ref.read(switchProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Connected Apps',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Control which app can access data stored in health connect. Tap an app to review its permission.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return CustomSwitch(
                    switchValue: switchValues[index],
                    onChanged: (value) {
                      switchNotifier.updateSwitch(index, value);
                    },
                  );
                }),
          ),
          // Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CommonButton(
              onPressed: () {
                ref.read(pageProvider.notifier).setPage(2);
              },
              text: "Next",
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSwitch extends StatelessWidget {
  final bool switchValue;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    required this.switchValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Color.fromARGB(143, 51, 91, 124),
      child: ListTile(
        contentPadding: EdgeInsets.all(8),
        leading: Material(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/health_connect.jpeg',
            height: 40,
          ),
        ),
        title: const Text(
          'Google Health Connect',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        trailing: Theme(
          data: ThemeData(useMaterial3: true),
          child: CupertinoSwitch(
            value: true,
            activeColor: Colors.green,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
