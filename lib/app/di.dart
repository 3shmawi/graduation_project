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
  //     'ENV.stripeTestKey';

  // final sharedPrefs = await SharedPreferences.getInstance();
  //
  // // shared prefs instance
  // instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
}

resetModules() {
  instance.reset(dispose: false);
  initAppModule();
}
