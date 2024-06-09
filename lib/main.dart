import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'app/app.dart';
import 'app/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
