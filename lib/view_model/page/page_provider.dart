import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ontrack/view/onboarding/tabs/connected_app.dart';
import 'package:ontrack/view/onboarding/tabs/select_first_goal.dart';
import 'package:ontrack/view/onboarding/tabs/setup_bio.dart';
import 'package:ontrack/view/onboarding/tabs/setup_plain.dart';

class PageProvider extends StateNotifier<int> {
  PageProvider() : super(0);

  void setPage(int index) {
    state = index;
  }

  void increment() {
    state++;
  }

  void decrement() {
    state--;
  }
}

class PagesListProvider extends StateNotifier<List<Widget>> {
  PagesListProvider()
      : super([
          SetupBio(),
          ConnectedApp(),
          SetupPlain(),
          SelectFirstGoal(),
        ]);

  List<Widget> get pages => state;
}
