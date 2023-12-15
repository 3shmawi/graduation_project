import 'package:donation/app/app_prefs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  await EasyLocalization.ensureInitialized();

  CacheHelper.init();
  // final sharedPrefs = await SharedPreferences.getInstance();
  //
  // // shared prefs instance
  // instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
}

resetModules() {
  instance.reset(dispose: false);
  initAppModule();
}
