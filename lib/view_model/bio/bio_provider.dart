import 'package:flutter_riverpod/flutter_riverpod.dart';

class AgeProvider extends StateNotifier<int> {
  AgeProvider() : super(18);

  void incrementAge() {
    state++;
  }

  void decrementAge() {
    state--;
  }
}

class HeightProvider extends StateNotifier<int> {
  HeightProvider() : super(150);

  void incrementHeight() {
    state++;
  }

  void decrementHeight() {
    state--;
  }
}

List<String> heightType = ['cm', 'ft'];

class HeightTypeProvider extends StateNotifier<String> {
  HeightTypeProvider() : super('cm');

  void changeHeightType(String type) {
    state = type;
  }
}

class TimeZoneNotifier extends StateNotifier<List<String>> {
  TimeZoneNotifier() : super([]);

  void setTimeZone(List<String> timeZones) {
    state = timeZones;
  }
}

class TimeZoneIndexNotifier extends StateNotifier<int> {
  TimeZoneIndexNotifier() : super(0);

  void setTimeZoneIndex(int index) {
    state = index;
  }

  void incrementTimeZoneIndex() {
    if (state == 629) {
      state = 0;
    } else {
      state++;
    }
  }

  void decrementTimeZoneIndex() {
    if (state == 0) {
      state = 629;
    } else {
      state--;
    }
  }
}
