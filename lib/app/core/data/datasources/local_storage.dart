import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._internal();
  static final LocalStorage instance = LocalStorage._internal();
  factory LocalStorage() => instance;
  SharedPreferences _prefs;

  clearStorage() async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
  }

  removeData(String key) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.remove(key);
  }

  setString(String key, String value) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(key, value);
  }

  setStringList(String key, List<String> value) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setStringList(key, value);
  }

  getString(String key) async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(key);
  }

  Future<List<String>> getStringList(String key) async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getStringList(key);
  }
}
