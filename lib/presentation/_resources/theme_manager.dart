import 'package:donation/presentation/_resources/color_manager.dart';
import 'package:donation/presentation/_resources/styles_manager.dart';
import 'package:donation/presentation/_resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors of the app
    primaryColor: AppColors.primary,
    primaryColorLight: AppColors.primaryOpacity70,
    primaryColorDark: AppColors.darkPrimary,
    disabledColor: AppColors.grey1,
    // ripple color
    splashColor: AppColors.primaryOpacity70,
    // will be used incase of disabled button for example
    hintColor: AppColors.grey,
    // card view theme
    cardTheme: CardTheme(
        color: AppColors.white,
        shadowColor: AppColors.grey,
        elevation: AppSize.s4),
    // App bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: AppColors.black,
      elevation: AppSize.s4,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
      shadowColor: AppColors.primaryOpacity70,
      titleTextStyle: getRobotoRegularStyle(
        color: AppColors.white,
        fontSize: FontSize.s16,
      ),
    ),
    // Button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: AppColors.grey1,
      buttonColor: AppColors.primary,
      splashColor: AppColors.primaryOpacity70,
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(AppSize.s255, AppSize.s50),
        textStyle: getRobotoRegularStyle(color: AppColors.white),
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),

    // Text theme
    textTheme: TextTheme(
      displayLarge: getRobotoSemiBoldStyle(
          color: AppColors.darkGrey, fontSize: FontSize.s16),
      displayMedium:
          getRobotoRegularStyle(color: AppColors.white, fontSize: FontSize.s16),
      displaySmall:
          getRobotoBoldStyle(color: AppColors.primary, fontSize: FontSize.s16),
      titleMedium: getRobotoMediumStyle(
          color: AppColors.lightGrey, fontSize: FontSize.s14),
      titleSmall: getRobotoMediumStyle(
          color: AppColors.primary, fontSize: FontSize.s14),
      bodyMedium: getRobotoMediumStyle(color: AppColors.lightGrey),
      bodySmall: getRobotoRegularStyle(color: AppColors.grey1),
      bodyLarge: getRobotoRegularStyle(color: AppColors.grey),
      labelLarge:
          getRobotoBoldStyle(color: AppColors.white, fontSize: FontSize.s16),
      labelMedium: getRobotoSemiBoldStyle(
          color: AppColors.grey1, fontSize: FontSize.s14),
      labelSmall: getRobotoLightStyle(
          color: AppColors.lightGrey, fontSize: FontSize.s12),
      titleLarge: getSansitoBoldStyle(color: AppColors.black),
      headlineLarge: getSansitoSemiBoldStyle(color: AppColors.primary),
      headlineMedium: getSansitaRegularStyle(
          color: AppColors.primary, fontSize: FontSize.s14),
      headlineSmall: getSansitoLightStyle(color: AppColors.primaryOpacity70),
    ),
    // input decoration theme (text form field)

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      // hint style
      hintStyle: getRobotoRegularStyle(color: AppColors.grey1),

      // label style
      labelStyle: getRobotoMediumStyle(color: AppColors.darkGrey),
      // error style
      errorStyle: getRobotoRegularStyle(color: AppColors.error),

      // enabled border
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

      // focused border
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

      // error border
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.error, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
      // focused error border
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
    ),
  );
}
