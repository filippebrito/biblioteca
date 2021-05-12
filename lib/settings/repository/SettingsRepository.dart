import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void insertBool(String key, bool value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(key, value);
  }

  Future<bool> getBool(String key) async{
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(key);
  }
}