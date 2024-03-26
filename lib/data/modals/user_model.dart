import 'package:cloud_firestore/cloud_firestore.dart';

import 'goal_modal.dart';

class User {
  int? age;
  int? height;
  String? heightMetric;
  String? timeZone;
  Plan? plan;
  List<Goal>? goal;

  User(
      {this.age,
      this.height,
      this.heightMetric,
      this.timeZone,
      this.plan,
      this.goal});

  User.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    height = json['height'];
    heightMetric = json['height_metric'];
    timeZone = json['time_zone'];
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
    if (json['goal'] != null) {
      goal = <Goal>[];
      json['goal'].forEach((v) {
        goal!.add(new Goal.fromJson(v));
      });
    }
  }
  User.fromSnapshot(DocumentSnapshot snapshot) {
    age = snapshot['age'];
    height = snapshot['height'];
    heightMetric = snapshot['height_metric'];
    timeZone = snapshot['time_zone'];
    plan = snapshot['plan'] != null ? Plan.fromJson(snapshot['plan']) : null;
    if (snapshot['goal'] != null) {
      goal = <Goal>[];
      snapshot['goal'].forEach((v) {
        goal!.add(Goal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    data['height'] = this.height;
    data['height_metric'] = this.heightMetric;
    data['time_zone'] = this.timeZone;
    if (this.plan != null) {
      data['plan'] = this.plan!.toJson();
    }
    if (this.goal != null) {
      data['goal'] = this.goal!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plan {
  String? planType;
  int? fatPercentage;

  Plan({this.planType, this.fatPercentage});

  Plan.fromJson(Map<String, dynamic> json) {
    planType = json['plan_type'];
    fatPercentage = json['fat_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plan_type'] = this.planType;
    data['fat_percentage'] = this.fatPercentage;
    return data;
  }
}
