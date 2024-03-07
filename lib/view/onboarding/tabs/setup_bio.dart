import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ontrack/data/modals/user_model.dart';
import 'package:ontrack/utils/app_contants.dart';
import 'package:ontrack/utils/common_button.dart';
import 'package:ontrack/view/onboarding/onboarding_n.dart';

import '../../../view_model/bio/bio_provider.dart';

final ageProvider = StateNotifierProvider<AgeProvider, int>((ref) {
  return AgeProvider();
});
final heightProvider = StateNotifierProvider<HeightProvider, int>((ref) {
  return HeightProvider();
});
final heightTypeProvider =
    StateNotifierProvider<HeightTypeProvider, String>((ref) {
  return HeightTypeProvider();
});

final timeZoneProvider =
    StateNotifierProvider<TimeZoneNotifier, List<String>>((ref) {
  return TimeZoneNotifier();
});
final timeZoneIndexProvider =
    StateNotifierProvider<TimeZoneIndexNotifier, int>((ref) {
  return TimeZoneIndexNotifier();
});

class SetupBio extends ConsumerWidget {
  const SetupBio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Setup your Bio',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Setup your bio We use this data to provide personalised recommendations on your goals and fitness routines.',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 30),
          Consumer(builder: (context, ref, child) {
            return CustomContainer(
              title: "My Age",
              value: ref.watch(ageProvider).toString(),
              increment: () => ref.read(ageProvider.notifier).incrementAge(),
              decrement: () => ref.read(ageProvider.notifier).decrementAge(),
            );
          }),
          Consumer(builder: (context, ref, child) {
            return CustomContainer(
              title: "My Height",
              value: ref.watch(heightProvider).toString(),
              increment: () =>
                  ref.read(heightProvider.notifier).incrementHeight(),
              decrement: () =>
                  ref..read(heightProvider.notifier).decrementHeight(),
            );
          }),
          Consumer(builder: (context, ref, child) {
            var index = ref.watch(timeZoneIndexProvider);
            print(index);
            return CustomContainer(
              title: "Time Zone",
              value: ref.read(timeZoneProvider).elementAt(index),
              increment: () => ref
                  .read(timeZoneIndexProvider.notifier)
                  .incrementTimeZoneIndex(),
              decrement: () => ref
                  .read(timeZoneIndexProvider.notifier)
                  .decrementTimeZoneIndex(),
            );
          }),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CommonButton(
                onPressed: () {
                  user = User();
                  user!.age = ref.read(ageProvider);
                  user!.height = ref.read(heightProvider);
                  user!.heightMetric = 'cm';
                  user!.timeZone = ref
                      .read(timeZoneProvider)[ref.read(timeZoneIndexProvider)];
                  ref.read(pageProvider.notifier).setPage(1);
                },
                text: "Next"),
          ),
        ],
      ),
    );
  }
}

class CustomContainer extends ConsumerWidget {
  final String title;
  final String value;
  final Function increment;
  final Function decrement;

  CustomContainer({
    required this.title,
    required this.value,
    required this.increment,
    required this.decrement,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.grey, width: 0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: (title == "My Height")
                ? EdgeInsets.only(right: 10.0)
                : EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                (title == "My Height")
                    ? Container(
                        height: double.infinity,
                        width: 70,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.3),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: Color.fromARGB(255, 66, 84, 138),
                        ),
                        child: DropdownButtonExample())
                    : SizedBox.shrink(),
                (title == "My Height")
                    ? SizedBox(width: 10)
                    : SizedBox.shrink(),
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
                      onTap: () => increment(),
                      child: Icon(
                        Icons.arrow_drop_up,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () => decrement(),
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
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Container(
        height: double.infinity,
        width: 70,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.3),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          color: Color(0xff061321),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton<String>(
          value: ref.watch(heightTypeProvider),
          onChanged: (String? value) {
            ref.read(heightTypeProvider.notifier).changeHeightType(value!);
          },
          underline: const SizedBox(),
          isExpanded: true,
          style: const TextStyle(color: Colors.black),
          dropdownColor: Color.fromARGB(255, 66, 84, 138),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          selectedItemBuilder: (BuildContext context) {
            return heightType.map((String value) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )),
              );
            }).toList();
          },
          items: heightType.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      );
    });
  }
}
