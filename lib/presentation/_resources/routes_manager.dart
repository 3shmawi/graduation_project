import 'package:donation/presentation/_resources/strings_manager.dart';
import 'package:donation/presentation/auth/email_verification/view.dart';
import 'package:donation/presentation/auth/forgotten_password/view.dart';
import 'package:donation/presentation/auth/login/view.dart';
import 'package:donation/presentation/auth/register/view.dart';
import 'package:donation/presentation/layout/layout_view.dart';
import 'package:donation/presentation/on_boarding/view.dart';
import 'package:flutter/material.dart';

import '../splash/view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String emailVerificationRoute = "/emailVerification";
  static const String layoutRoute = "/layout";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      //splash
      case Routes.splashRoute:
        return _secondTransitionAnimation(settings, const SplashView());

      //onboard
      case Routes.onBoardingRoute:
        return _secondTransitionAnimation(settings, const OnBoardingView());

      //auth
      case Routes.loginRoute:
        return _secondTransitionAnimation(settings, const LoginPage());
      case Routes.registerRoute:
        return _secondTransitionAnimation(settings, const RegisterPage());
      case Routes.forgotPasswordRoute:
        return _firstTransitionAnimation(
            settings, const ForgottenPasswordPage());
      case Routes.emailVerificationRoute:
        return _secondTransitionAnimation(
            settings, const EmailVerificationPage());

      //layout
      case Routes.layoutRoute:
        return _firstTransitionAnimation(settings, const LayoutPage());

      //other
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.noRoute),
        ),
        body: Center(
          child: Text(AppStrings.noRoute),
        ),
      ),
    );
  }
}

Route<dynamic> _firstTransitionAnimation(RouteSettings settings, Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      animation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInCirc,
      );
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    settings: settings,
  );
}

Route<dynamic> _secondTransitionAnimation(RouteSettings settings, Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      animation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInCirc,
      );
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    settings: settings,
  );
}
