import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ontrack/data/modals/user_model.dart';
import 'package:ontrack/utils/app_contants.dart';
import 'package:ontrack/utils/common_button.dart';
import 'package:ontrack/view/onboarding/onboarding_n.dart';
import 'package:ontrack/view_model/plain/plain_provider.dart';
import '../../../view_model/bio/bio_provider.dart';

final planNameProvider = StateNotifierProvider<PlanNameNotifier, String>((ref) {
  return PlanNameNotifier();
});

final goalMeasureProvider =
    StateNotifierProvider<GoalMeasureNotifier, String>((ref) {
  return GoalMeasureNotifier();
});

final goalMetricProvider =
    StateNotifierProvider<GoalMetricNotifier, int>((ref) {
  return GoalMetricNotifier();
});

class SetupPlain extends ConsumerStatefulWidget {
  const SetupPlain({super.key});

  @override
  ConsumerState<SetupPlain> createState() => _SetupBioState();
}

class _SetupBioState extends ConsumerState<SetupPlain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Setup your plan',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Control which app can access data stored in health connect. Tap an app to review its permission.',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            initialValue: ref.watch(planNameProvider),
            onChanged: (value) {
              ref.read(planNameProvider.notifier).updatePlanName(value);
            },
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              labelText: 'Plan Name',
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 20),
          IncrementDecrementContainer(
            text: 'Goal Measure',
            value: ref.watch(goalMeasureProvider),
            onIncrement: () =>
                ref.read(goalMeasureProvider.notifier).incrementGoalMeasure(),
            onDecrement: () =>
                ref.read(goalMeasureProvider.notifier).decrementGoalMeasure(),
          ),
          SizedBox(height: 20),
          IncrementDecrementContainer(
            text: 'Goal Metric',
            value: ref.watch(goalMetricProvider).toString(),
            onIncrement: () =>
                ref.read(goalMetricProvider.notifier).incrementGoalMetric(),
            onDecrement: () =>
                ref.read(goalMetricProvider.notifier).decrementGoalMetric(),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CommonButton(
                onPressed: () {
                  user!.plan = Plan();
                  user!.plan!.planType = ref.read(planNameProvider);
                  user!.plan!.fatPercentage = ref.read(goalMetricProvider);
                  ref.read(pageProvider.notifier).setPage(3);
                },
                text: "Next"),
          ),
        ],
      ),
    );
  }
}

class IncrementDecrementContainer extends StatelessWidget {
  final String text;
  final String value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  IncrementDecrementContainer({
    required this.text,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.grey, width: 0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: onIncrement,
                  child: Icon(
                    Icons.arrow_drop_up,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: onDecrement,
                  child: Icon(
                    Icons.arrow_drop_down,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
