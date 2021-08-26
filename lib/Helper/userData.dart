import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  // static String userToken = "USERTOKEN";
  static String UserLanguage = "USERLANG";

  static Future setUserToken(
      {required String key, required String value}) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(key, value);
  }

  static Future getUserToken(String key) async {
    final pref = await SharedPreferences.getInstance();

    return pref.getString(key);
  }

  static Future clearData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  // for Language
  static Future setUserLanguage(
      {required String key, required String value}) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(key, value);
  }

  static Future getUserLanguage(String key) async {
    final pref = await SharedPreferences.getInstance();

    return pref.getString(key);
  }
}
