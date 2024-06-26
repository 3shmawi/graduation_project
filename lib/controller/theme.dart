import 'package:donation/app/enums.dart';
import 'package:donation/services/local_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCtrl extends Cubit<bool> {
  ThemeCtrl()
      : super(CacheHelper.getData(key: SharedPrefKeys.userTheme) ?? false);

  void changeTheme() {
    CacheHelper.saveData(key: SharedPrefKeys.userTheme, value: !state);
    emit(!state);
  }
}
