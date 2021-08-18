import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  // static String userToken = "USERTOKEN";

  static Future setUserToken(
      {required String key, required String value}) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(key, value);
  }

  static Future getUserToken(String key) async {
    final pref = await SharedPreferences.getInstance();

    return pref.getString(key);
  }
}
