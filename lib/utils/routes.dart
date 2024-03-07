import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ontrack/view/onboarding/onboarding_n.dart';
import 'package:ontrack/view/onboarding/onboarding_one.dart';
import 'package:ontrack/view/onboarding/tabs/setup_bio.dart';

var router = GoRouter(initialLocation: OnboardingOne.routeName, routes: [
  GoRoute(
      path: OnboardingOne.routeName,
      pageBuilder: (context, state) => MaterialPage(child: OnboardingOne()),
      routes: [
        GoRoute(
            path: Onboarding.routeName,
            name: Onboarding.routeName,
            pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: Onboarding(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                              begin: const Offset(1, 0), end: Offset.zero)
                          .animate(animation),
                      child: child,
                    );
                  },
                )),
      ]),
]);
