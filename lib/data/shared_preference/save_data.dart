import 'package:shared_preferences/shared_preferences.dart';

class SaveData {
  static late bool _darkTheme;
  static late bool _isKorea;
////////////////theme//////////////////////
  static void setThemeData(bool value) {
    _darkTheme = value;
  }

  static bool getThemeData() {
    return _darkTheme;
  }
////////////////local/////////////////////
  static void setLanguage(bool value) {
    _isKorea = value;
  }

  static bool getLanguage() {
    return _isKorea;
  }
/////////////////save////////////////////////////////////////////
  static void save(String key, bool value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool(key, value);
  }
}
