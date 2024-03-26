import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ontrack/firebase_options.dart';
import 'package:ontrack/utils/color_resources.dart';
import 'package:ontrack/utils/routes.dart';
import 'package:ontrack/view/onboarding/onboarding_one.dart';
import 'package:ontrack/view_model/user/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'data/modals/user_model.dart';
import 'view/Home/home_page_collapse.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = ColorResources.primaryColor
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5);
  runApp(ProviderScope(child: MyApp()));
}

var userProvider = StateNotifierProvider<UserProvider, User?>((ref) {
  return UserProvider();
});

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late Widget home;
  var isLoading = true;
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    var pref = await SharedPreferences.getInstance();
    var firstTime = pref.getBool('isFirstTime') ?? false;
    if (!firstTime) {
      var id = Uuid().v1();
      pref.setString('device_id', id);
      setState(() {
        home = OnboardingOne();
        isLoading = false;
      });
    } else {
      var id = pref.getString('device_id');
      await ref.read(userProvider.notifier).getUserData(id!);
      setState(() {
        home = HomePageCollapse();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OnTrack',
      builder: EasyLoading.init(),
      home: isLoading
          ? Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: CircularProgressIndicator(
                  color: ColorResources.gradientColor,
                ),
              ),
            )
          : home,
    );
  }
}
