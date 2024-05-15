import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool value(String value) => _prefs.getBool(value) ?? false;

  static setValue(String title, bool value) {
    _prefs.setBool(title, value);
  }
}
