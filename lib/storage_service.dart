import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static StorageService? _instance;
  static SharedPreferences? _preferences;

  static Future<StorageService?> getInstance() async {
    if (_instance == null) {
      _instance = StorageService();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  static Future<bool> putString(String key, value) {
    if (_preferences == null) return Future.value(false);
    return _preferences!.setString(key, value);
  }

  static String getString(String key, {String defValue = ""}) {
    if (_preferences == null) return defValue;
    return _preferences!.getString(key) ?? defValue;
  }
}
