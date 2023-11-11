import 'dart:async';

import 'package:donation/presentation/_resources/assets_manager.dart';
import 'package:donation/presentation/_resources/color_manager.dart';
import 'package:donation/presentation/_resources/constants_manager.dart';
import 'package:donation/presentation/_resources/font_manager.dart';
import 'package:donation/presentation/_resources/strings_manager.dart';
import 'package:donation/presentation/_resources/values_manager.dart';
import 'package:flutter/material.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../_resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() async {
    _appPreferences.isOnBoardingScreenViewed().then(
          (isOnBoardingScreenViewed) => {
            if (isOnBoardingScreenViewed)
              {
                _appPreferences.isUserLoggedIn().then(
                      (isUserLoggedIn) => {
                        if (isUserLoggedIn)
                          {
                            Navigator.pushReplacementNamed(
                                context, Routes.layoutRoute),
                          }
                        else
                          {
                            Navigator.pushReplacementNamed(
                                context, Routes.loginRoute),
                          }
                      },
                    ),
              }
            else
              {
                Navigator.pushReplacementNamed(context, Routes.onBoardingRoute),
              }
          },
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
          Image.asset(
            AppAssets.logo,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: AppSize.s200),
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
