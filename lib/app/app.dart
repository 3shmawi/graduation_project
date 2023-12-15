import 'package:donation/presentation/_resources/logic/view_model.dart';
import 'package:donation/presentation/layout/home/search/view_model.dart';
import 'package:donation/presentation/layout/layout_view_model.dart';
import 'package:donation/presentation/layout/profile/view_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'global_imports.dart';

import 'package:donation/presentation/on_boarding/view_model.dart';
import 'package:easy_localization/easy_localization.dart';

import '../presentation/_resources/routes_manager.dart';
import '../presentation/_resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppLogicVM()),
        BlocProvider(create: (_) => OnBoardingVM()),
        BlocProvider(create: (_) => LayoutVM()),
        BlocProvider(create: (_) => SearchVM()..getRecentSearchList()),
        BlocProvider(create: (_) => SettingVM()..initPackageInfo()),
      ],
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          final logic = context.watch<AppLogicVM>();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,

            themeMode: logic.isDark ? ThemeMode.dark : ThemeMode.light,

            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.splashRoute,
            // theme: getApplicationTheme(),
          );
        },
      ),
    );
  }
}
