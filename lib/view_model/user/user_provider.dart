import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ontrack/data/modals/user_model.dart';

class UserProvider extends StateNotifier<User?> {
  UserProvider() : super(null);

  void setUser(User user) {
    state = user;
  }
}
