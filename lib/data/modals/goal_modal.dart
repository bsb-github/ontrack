class Goal {
  String? _goalName;
  String? _goalValue;
  String? _goalSubtile;
  String? _goalMetric;

  Goal(
      {String? goalName,
      String? goalValue,
      String? goalSubtile,
      String? goalMetric}) {
    if (goalName != null) {
      this._goalName = goalName;
    }
    if (goalValue != null) {
      this._goalValue = goalValue;
    }
    if (goalSubtile != null) {
      this._goalSubtile = goalSubtile;
    }
    if (goalMetric != null) {
      this._goalMetric = goalMetric;
    }
  }

  String? get goalName => _goalName;
  set goalName(String? goalName) => _goalName = goalName;
  String? get goalValue => _goalValue;
  set goalValue(String? goalValue) => _goalValue = goalValue;
  String? get goalSubtile => _goalSubtile;
  set goalSubtile(String? goalSubtile) => _goalSubtile = goalSubtile;
  String? get goalMetric => _goalMetric;
  set goalMetric(String? goalMetric) => _goalMetric = goalMetric;

  Goal.fromJson(Map<String, dynamic> json) {
    _goalName = json['goal_name'];
    _goalValue = json['goal_value'];
    _goalSubtile = json['goal_subtile'];
    _goalMetric = json['goal_metric'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goal_name'] = this._goalName;
    data['goal_value'] = this._goalValue;
    data['goal_subtile'] = this._goalSubtile;
    data['goal_metric'] = this._goalMetric;
    return data;
  }
}

List<Goal> goals = [
  Goal(
      goalMetric: 'times',
      goalName: "Gym",
      goalSubtile: "3 Times a week",
      goalValue: "3"),
  Goal(
      goalMetric: 'gram',
      goalName: "Protein",
      goalSubtile: "130g Protein a day",
      goalValue: "130"),
  Goal(
      goalMetric: 'gram',
      goalName: "Muscle Mass",
      goalSubtile: "200g a week",
      goalValue: "200"),
  Goal(
      goalMetric: 'k',
      goalName: "Step Tracker",
      goalSubtile: "10k Steps a day",
      goalValue: "10000"),
  Goal(
      goalMetric: 'hrs',
      goalName: "Sleep",
      goalSubtile: "8hrs a day",
      goalValue: "8"),
  Goal(
      goalMetric: 'cal',
      goalName: "Calories",
      goalSubtile: "2000 Calories in a week",
      goalValue: "2000"),
];
