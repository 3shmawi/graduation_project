import 'package:donation/app/app_prefs.dart';
import 'package:donation/app/global_imports.dart';

class AppLogicVM extends Cubit<AppCubitStates> {
  AppLogicVM() : super(AppLogicInitState());

  bool get isDark => _isDark;

  bool get isArabic => _isArabic;

  bool _isDark = CacheHelper.getData(key: Enums.IS_DARK) ?? false;

  void toggleTheme() {
    _isDark = !_isDark;
    CacheHelper.saveData(key: Enums.IS_DARK, value: _isDark);
    emit(ChangeDarkThemeState());
  }

  bool _isArabic = CacheHelper.getData(key: Enums.IS_ARABIC) ?? true;

  void toggleLanguage() {
    _isArabic = !_isArabic;
    CacheHelper.saveData(key: Enums.IS_ARABIC, value: _isArabic);
    emit(ChangeLanguageState());
  }
}

enum Enums {
  IS_DARK,
  IS_ARABIC,
  IS_BOARDING,
  IS_REGISTERD,
  IS_LOGIED_IN,
}
