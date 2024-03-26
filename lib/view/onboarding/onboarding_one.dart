import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:go_router/go_router.dart';
import 'package:ontrack/services/step_counter_service.dart';
import 'package:ontrack/utils/app_contants.dart';
import 'package:ontrack/utils/common_button.dart';
import 'package:ontrack/view/onboarding/onboarding_n.dart';
import 'package:ontrack/view/onboarding/tabs/setup_bio.dart';
import 'package:ontrack/view_model/health/steps_provider.dart';
import 'package:permission_handler/permission_handler.dart';

var stepProvider =
    StateNotifierProvider<StepsProvider, List<Map<String, String>>>((ref) {
  return StepsProvider();
});

class OnboardingOne extends ConsumerStatefulWidget {
  static const String routeName = '/onboarding_one';
  const OnboardingOne({super.key});

  @override
  ConsumerState<OnboardingOne> createState() => _OnboardingOneState();
}

class _OnboardingOneState extends ConsumerState<OnboardingOne> {
  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  void requestPermission() async {
    await Permission.activityRecognition.request();
    await Permission.location.request();
    final currentTimeZone = await FlutterTimezone.getAvailableTimezones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    ref.read(timeZoneIndexProvider.notifier).setTimeZoneIndex(currentTimeZone
        .where((element) => element == timeZoneName)
        .toList()
        .indexOf(timeZoneName));
    ref.read(timeZoneProvider.notifier).setTimeZone(currentTimeZone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              flex: 8,
              child: Image.asset(
                AppConstants.bgImage,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        'Welcome to onTrack',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Start by connecting your health apps and we will help you create a plan to reach your goals.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Consumer(
                          builder: (context, reff, child) => CommonButton(
                              onPressed: () {
                                ref
                                    .read(stepProvider.notifier)
                                    .getStepsFor7day();

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Onboarding()));

                                // context.goNamed(Onboarding.routeName);
                              },
                              text: "Next"),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }
}
