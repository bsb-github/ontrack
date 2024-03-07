import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlanNameNotifier extends StateNotifier<String> {
  List<String> plan = [
    'Get fit for summer',
    'Get fit for winter',
    'Get fit for 1',
    'Get fit for 2',
  ];
  int planIndex = 0;

  PlanNameNotifier() : super('Get fit for summer');

  void incrementPlanName() {
    if (planIndex < 3) {
      state = plan[++planIndex];
    }
  }

  void decrementPlanName() {
    if (planIndex > 0) {
      state = plan[--planIndex];
    }
  }
}

class GoalMeasureNotifier extends StateNotifier<String> {
  List<String> goal = [
    "Bodyfat percentage 1",
    "Bodyfat percentage 2",
    "Bodyfat percentage 3",
    "Bodyfat percentage 4",
  ];
  int goalIndex = 0;

  GoalMeasureNotifier() : super('Bodyfat percentage');

  void incrementGoalMeasure() {
    if (goalIndex < 3) {
      state = goal[++goalIndex];
    }
  }

  void decrementGoalMeasure() {
    if (goalIndex > 0) {
      state = goal[--goalIndex];
    }
  }
}

class GoalMetricNotifier extends StateNotifier<int> {
  GoalMetricNotifier() : super(18);

  void incrementGoalMetric() {
    state++;
  }

  void decrementGoalMetric() {
    if (state > 0) {
      state--;
    }
  }
}
