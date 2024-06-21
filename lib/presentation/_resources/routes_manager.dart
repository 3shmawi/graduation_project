import 'package:donation/presentation/_resources/strings_manager.dart';
import 'package:donation/presentation/auth/email_verification/view.dart';
import 'package:donation/presentation/auth/forgotten_password/view.dart';
import 'package:donation/presentation/auth/login/view.dart';
import 'package:donation/presentation/auth/register/view.dart';
import 'package:donation/presentation/auth/success/view.dart';
import 'package:donation/presentation/layout/campaign/details.dart';
import 'package:donation/presentation/layout/home/search/view.dart';
import 'package:donation/presentation/layout/layout_view.dart';
import 'package:donation/presentation/layout/profile/security.dart';
import 'package:donation/presentation/on_boarding/view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../layout/home/comments/comment_view.dart';
import '../layout/home/notifications/notifications.dart';
import '../splash/choose_language.dart';
import '../splash/view.dart';

class Routes {
  static const splashRoute = "/";

  static const chooseLanguageRoute = "chooseLanguage";

  static const onBoardingRoute = "/onBoarding";

  // static const authRoute = "/auth";
  static const loginRoute = "/login";
  static const registerRoute = "/register";
  static const forgotPasswordRoute = "/forgotPassword";
  static const emailVerificationRoute = "/emailVerification";
  static const successRoute = "/success";

  static const layoutRoute = "/layout";

  static const campaignDetailsRoute = "/detailsCampaign";

  static const securityRoute = "/security";

  static const searchRoute = "/search";
  static const norifications = "/notification";
  static const comments = "comment";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      //splash
      case Routes.splashRoute:
        return _secondTransitionAnimation(settings, const SplashView());

      //select lang
      case Routes.chooseLanguageRoute:
        return _secondTransitionAnimation(settings, const ChooseLanguagePage());

      //onboard
      case Routes.onBoardingRoute:
        return _secondTransitionAnimation(settings, const OnBoardingView());

      //auth
      // case Routes.authRoute:
      //   return FadeRoute2(const LoginPage());

      case Routes.loginRoute:
        return FadeRoute2(const LoginPage());
      case Routes.registerRoute:
        return FadeRoute2(const RegisterPage());
      case Routes.forgotPasswordRoute:
        return _firstTransitionAnimation(
            settings,  ForgottenPasswordPage());
      case Routes.emailVerificationRoute:
        return _secondTransitionAnimation(
            settings, const EmailVerificationPage());
      case Routes.successRoute:
        return _secondTransitionAnimation(settings, const SuccessPage());

      //layout
      case Routes.layoutRoute:
        return _firstTransitionAnimation(settings, const LayoutPage());

      //campaign detail
      case Routes.campaignDetailsRoute:
        return FadeRoute2(const CampaignDetailsScreen());

      //security
      case Routes.securityRoute:
        return FadeRoute2(const SecurityPage());

      //search
      case Routes.searchRoute:
        return FadeRoute1(const SearchPage());
      // notifications
      case Routes.norifications:
        return FadeRoute3(const Notifications());
      //comments
      case Routes.comments:
        return FadeRoute4(const Comment());

      //other
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.noRoute).tr(),
        ),
        body: Center(
          child: Text(AppStrings.noRoute).tr(),
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

class FadeRoute1 extends PageRouteBuilder {
  final Widget page;

  FadeRoute1(this.page)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: page,
          ),
        );
}

class FadeRoute2 extends PageRouteBuilder {
  final Widget page;

  FadeRoute2(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(seconds: 2),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return FadeTransition(
              opacity: animation,
              child: page,
            );
          },
        );
}

class FadeRoute3 extends PageRouteBuilder {
  final Widget page;

  FadeRoute3(this.page)
      : super(
    pageBuilder: (context, animation, anotherAnimation) => page,
    transitionDuration: const Duration(seconds: 2),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, anotherAnimation, child) {
      animation = CurvedAnimation(
          curve: Curves.fastLinearToSlowEaseIn,
          parent: animation,
          reverseCurve: Curves.fastOutSlowIn);
      return FadeTransition(
        opacity: animation,
        child: page,
      );
    },
  );
}
class FadeRoute4 extends PageRouteBuilder {
  final Widget page;

  FadeRoute4(this.page)
      : super(
    pageBuilder: (context, animation, anotherAnimation) => page,
    transitionDuration: const Duration(seconds: 2),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, anotherAnimation, child) {
      animation = CurvedAnimation(
          curve: Curves.fastLinearToSlowEaseIn,
          parent: animation,
          reverseCurve: Curves.fastOutSlowIn);
      return FadeTransition(
        opacity: animation,
        child: page,
      );
    },
  );
}
