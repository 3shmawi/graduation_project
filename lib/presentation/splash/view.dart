import 'dart:async';
import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/_resources/logic/view_model.dart';

import '../_resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() {
    final appLogic = context.read<AppLogicVM>();

    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.chooseLanguageRoute,
      (_) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image.asset(
            AppAssets.splash,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.logo,
                ),
                RichText(
                  text: TextSpan(
                    text: AppStrings.splashTitle,
                    style: TextStyle(
                      fontSize: FontSize.s24,
                      fontWeight: FontWeight.w700,
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: [
                            AppColors.gradient1,
                            AppColors.gradient2,
                            AppColors.gradient3,
                          ],
                        ).createShader(
                          const Rect.fromLTWH(
                            100.0,
                            100.0,
                            200.0,
                            200.0,
                          ),
                        ),
                    ),
                  ),
                ),
                Text(
                  AppStrings.splashSubTitle,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
