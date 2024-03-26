import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ontrack/data/modals/user_model.dart';

class UserProvider extends StateNotifier<User?> {
  UserProvider() : super(null);

  void setUser(User user) {
    state = user;
  }

  Future<void> getUserData(String deviceID) async {
    print(deviceID);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(deviceID)
        .get()
        .then((value) {
      print("samdla " + User.fromSnapshot(value).age.toString());
      setUser(User.fromSnapshot(value));
    });
  }
}
