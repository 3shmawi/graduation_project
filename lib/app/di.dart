import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../presentation/layout/bookmark/model/post.dart';
import '../services/local_database.dart';
import '../services/local_notification.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  await EasyLocalization.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(PostAdapter());
  await LocalNotificationService.initialize();
  FirebaseMessaging.instance.subscribeToTopic("all");

  CacheHelper.init();
  // Stripe.publishableKey =
  //     'pk_test_51PV4TxCsRNq51OBYsPPUj8NdhOA5Lzh8dUSq5v1HgGroIK5z2e4YqJFmSzjUgnwztBcYooQHeBLW5bxtXG1taU3500EtibMkom';

  // final sharedPrefs = await SharedPreferences.getInstance();
  //
  // // shared prefs instance
  // instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
}

resetModules() {
  instance.reset(dispose: false);
  initAppModule();
}
