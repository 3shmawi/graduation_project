import 'package:donation/presentation/layout/layout_view_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'global_imports.dart';

import 'package:donation/presentation/on_boarding/view_model.dart';
import 'package:easy_localization/easy_localization.dart';

import '../presentation/_resources/routes_manager.dart';
import '../presentation/_resources/theme_manager.dart';
import 'app_prefs.dart';
import 'di.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) => {context.setLocale(local)});

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OnBoardingVM()),
        BlocProvider(create: (_) => LayoutVM()),
      ],
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.splashRoute,
            theme: getApplicationTheme(),
          );
        },
      ),
    );
  }
}
