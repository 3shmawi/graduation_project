import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'app/app.dart';
import 'app/di.dart';
import 'firebase_options.dart';

//firypowe@teleg.eu
//abdosheredam90@gmail.com
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initAppModule();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale("ar", "SA"),
        Locale("en", "US"),
      ],
      path: "assets/translations",
      child: Phoenix(
        child: const MyApp(),
      ),
    ),
  );
}
