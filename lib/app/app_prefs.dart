// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../presentation/_resources/language_manager.dart';
//
// const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
// const String IS_DARK = "IS_DARK";
// const String PREFS_KEY_ONBOARDING_SCREEN = "PREFS_KEY_ONBOARDING_SCREEN";
// const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";
// const String PREFS_KEY_TOKEN = "PREFS_KEY_TOKEN";
//
// class AppPreferences {
//   final SharedPreferences _sharedPreferences;
//
//   AppPreferences(this._sharedPreferences);
//
//   Future toggleTheme() async {
//     bool isDark = _sharedPreferences.getBool(IS_DARK) ?? false;
//
//      _sharedPreferences.setBool(IS_DARK, !isDark);
//   }
//
//   Future<String> getAppLanguage() async {
//     String? language = _sharedPreferences.getString(PREFS_KEY_LANG);
//
//     if (language != null && language.isNotEmpty) {
//       return language;
//     } else {
//       return LanguageType.ARABIC.getValue();
//     }
//   }
//
//   Future<void> setLanguageChanged() async {
//     String currentLanguage = await getAppLanguage();
//     if (currentLanguage == LanguageType.ARABIC.getValue()) {
//       // save prefs with english lang
//       _sharedPreferences.setString(
//           PREFS_KEY_LANG, LanguageType.ENGLISH.getValue());
//     } else {
//       // save prefs with arabic lang
//       _sharedPreferences.setString(
//           PREFS_KEY_LANG, LanguageType.ARABIC.getValue());
//     }
//   }
//
//   Future<Locale> getLocal() async {
//     String currentLanguage = await getAppLanguage();
//     if (currentLanguage == LanguageType.ARABIC.getValue()) {
//       // return arabic local
//       return ARABIC_LOCAL;
//     } else {
//       // return english local
//       return ENGLISH_LOCAL;
//     }
//   }
//
//   Future<void> setOnBoardingScreenViewed() async {
//     _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN, true);
//   }
//
//   Future<bool> isOnBoardingScreenViewed() async {
//     return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN) ?? false;
//   }
//
//   Future<void> setUserToken(String token) async {
//     _sharedPreferences.setString(PREFS_KEY_TOKEN, token);
//   }
//
//   Future<String> getUserToken() async {
//     return _sharedPreferences.getString(PREFS_KEY_TOKEN) ?? "";
//   }
//
//   Future<void> setIsUserLoggedIn() async {
//     _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
//   }
//
//   Future<bool> isUserLoggedIn() async {
//     return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
//   }
//
//   Future<void> logout() async {
//     _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
//   }
// }

import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/_resources/logic/view_model.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({
    required Enums key,
  }) {
    return sharedPreferences.get(key.name);
  }

  static Future<bool> saveData({
    required Enums key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key.name, value);
    if (value is int) return await sharedPreferences.setInt(key.name, value);
    if (value is bool) return await sharedPreferences.setBool(key.name, value);
    if (value is double) return await sharedPreferences.setDouble(key.name, value);
    return await sharedPreferences.setStringList(key.name, value);
  }

  static Future<bool> removeData({
    required Enums key,
  }) async {
    return await sharedPreferences.remove(key.name);
  }
}
