import 'package:donation/app/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({
    required SharedPrefKeys key,
  }) {
    return sharedPreferences.get(key.name);
  }

  static Future<bool> saveData({
    required SharedPrefKeys key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key.name, value);
    }
    if (value is int) return await sharedPreferences.setInt(key.name, value);
    if (value is bool) return await sharedPreferences.setBool(key.name, value);
    if (value is double) {
      return await sharedPreferences.setDouble(key.name, value);
    }
    return await sharedPreferences.setStringList(key.name, value);
  }

  static Future<bool> removeData({
    required SharedPrefKeys key,
  }) async {
    return await sharedPreferences.remove(key.name);
  }
}
