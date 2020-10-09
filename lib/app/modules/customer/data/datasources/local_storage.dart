import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._internal();
  static final LocalStorage instance = LocalStorage._internal();
  factory LocalStorage() => instance;

  clearStorage() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
  }

  setString(String key, String value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(key, value);
  }

  Future<String> getString(String value) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(value);
  }
}
