// import 'package:donation/app/enums.dart';
// import 'package:donation/app/global_imports.dart';
//
// import '../../../services/local_database.dart';
//
// class AppLogicVM extends Cubit<AppCubitStates> {
//   AppLogicVM() : super(AppLogicInitState());
//
//   bool get isDark => _isDark;
//
//   bool _isDark = CacheHelper.getData(key: SharedPrefKeys.userTheme) ?? false;
//
//   void toggleTheme() {
//     _isDark = !_isDark;
//     CacheHelper.saveData(key: SharedPrefKeys.userTheme, value: _isDark);
//     emit(ChangeDarkThemeState());
//   }
// }
