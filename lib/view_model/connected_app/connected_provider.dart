import 'package:flutter_riverpod/flutter_riverpod.dart';

final switchProvider = StateNotifierProvider<SwitchNotifier, List<bool>>((ref) {
  return SwitchNotifier();
});

class SwitchNotifier extends StateNotifier<List<bool>> {
  SwitchNotifier() : super([true, true, true, true, false]);

  void updateSwitch(int index, bool value) {
    state = [
      for (var i = 0; i < state.length; i++)
        if (i == index) value else state[i],
    ];
  }
}
