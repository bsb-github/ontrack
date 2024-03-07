import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ontrack/data/modals/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo {
  final store = FirebaseFirestore.instance;
  Future<bool> registerDevice(User user) async {
    var prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("device_id");
    try {
      await store.collection('users').doc(id).set(user.toJson());
      EasyLoading.dismiss();
      return true;
    } on FirebaseException catch (e) {
      EasyLoading.showError(e.message!);
      EasyLoading.dismiss();
      return false;
    }
  }
}
