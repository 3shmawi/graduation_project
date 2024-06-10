import 'package:donation/presentation/_resources/color_manager.dart';
import 'package:donation/presentation/_resources/styles_manager.dart';
import 'package:donation/presentation/_resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'font_manager.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    colorScheme: const ColorScheme.light(),
    primaryColor: AppColors.primary,
    primaryColorLight: AppColors.primaryOpacity70,
    primaryColorDark: AppColors.darkPrimary,
    disabledColor: AppColors.grey1,
    splashColor: AppColors.primaryOpacity70,
    hintColor: AppColors.grey,
    cardTheme: CardTheme(
      color: AppColors.white,
      shadowColor: AppColors.black,
      surfaceTintColor: AppColors.white,
      elevation: AppSize.s4,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.only(top: AppPadding.p6),
      hintStyle: getRegularStyle(color: AppColors.grey1),
      labelStyle: getMediumStyle(color: AppColors.darkGrey),
      errorStyle: getRegularStyle(color: AppColors.error),
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(AppWidth.w255, AppHeight.h50),
        textStyle: getRegularStyle(color: AppColors.white),
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSize.s8,
          ),
        ),
      ),
    ),

    // Text theme
    textTheme: TextTheme(
      //black
      displayLarge:
          getBoldStyle(color: AppColors.black, fontSize: FontSize.s24),
      displayMedium:
          getRegularStyle(color: AppColors.black, fontSize: FontSize.s16),
      displaySmall:
          getSemiBoldStyle(color: AppColors.black, fontSize: FontSize.s16),

      //primary
      titleLarge:
          getBoldStyle(color: AppColors.primary, fontSize: FontSize.s24),
      titleMedium:
          getMediumStyle(color: AppColors.primary, fontSize: FontSize.s18),
      titleSmall:
          getMediumStyle(color: AppColors.primary, fontSize: FontSize.s14),

      //primary with opacity
      bodyLarge: getRegularStyle(
          color: AppColors.primaryOpacity70, fontSize: FontSize.s20),
      bodyMedium: getMediumStyle(
          color: AppColors.primaryOpacity70, fontSize: FontSize.s16),
      bodySmall: getRegularStyle(
          color: AppColors.primaryOpacity70, fontSize: FontSize.s14),

      //gray
      labelLarge: getBoldStyle(color: AppColors.grey, fontSize: FontSize.s20),
      labelMedium:
          getSemiBoldStyle(color: AppColors.grey, fontSize: FontSize.s18),
      labelSmall: getLightStyle(color: AppColors.grey, fontSize: FontSize.s14),

      //white
      headlineLarge:
          getBoldStyle(color: AppColors.white, fontSize: FontSize.s24),
      headlineMedium:
          getMediumStyle(color: AppColors.white, fontSize: FontSize.s18),
      headlineSmall:
          getLightStyle(color: AppColors.white, fontSize: FontSize.s14),
    ),
  );

  static final ThemeData dark = ThemeData(
    colorScheme: const ColorScheme.dark(),
    primaryColor: AppColors.primary,
    primaryColorLight: AppColors.primaryOpacity70,
    primaryColorDark: AppColors.darkPrimary,
    disabledColor: AppColors.grey1,
    splashColor: AppColors.primaryOpacity70,
    hintColor: AppColors.grey,
    cardTheme: CardTheme(
      surfaceTintColor: AppColors.black,
      shadowColor: AppColors.grey,
      elevation: AppSize.s8,
    ),
    iconTheme: IconThemeData(color: AppColors.white.withOpacity(.8)),
    appBarTheme: AppBarTheme(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppSize.s8),
        ),
      ),
      backgroundColor: AppColors.darkAppBarBackground,
      // Use dark background for app bar
      foregroundColor: AppColors.white,
      // Use light text color for app bar
      elevation: 0,
      shadowColor: Colors.white10,
      centerTitle: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      titleTextStyle:
          getBoldStyle(color: AppColors.white, fontSize: FontSize.s24),
    ),
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: AppColors.grey1,
      buttonColor: AppColors.primary,
      splashColor: AppColors.primaryOpacity70,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(AppWidth.w255, AppHeight.h50),
        textStyle: getRegularStyle(color: AppColors.white),
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),
    // Text theme
    textTheme: TextTheme(
      //black
      displayLarge: getBoldStyle(
          color: AppColors.white.withOpacity(.5), fontSize: FontSize.s24),
      displayMedium: getRegularStyle(
          color: AppColors.white.withOpacity(.5), fontSize: FontSize.s16),
      displaySmall: getSemiBoldStyle(
          color: AppColors.white.withOpacity(.5), fontSize: FontSize.s16),

      //primary
      titleLarge:
          getBoldStyle(color: AppColors.primary, fontSize: FontSize.s24),
      titleMedium:
          getMediumStyle(color: AppColors.primary, fontSize: FontSize.s18),
      titleSmall:
          getMediumStyle(color: AppColors.primary, fontSize: FontSize.s14),

      //primary with opacity
      bodyLarge: getRegularStyle(
          color: AppColors.primaryOpacity70, fontSize: FontSize.s20),
      bodyMedium: getMediumStyle(
          color: AppColors.primaryOpacity70, fontSize: FontSize.s16),
      bodySmall: getRegularStyle(
          color: AppColors.primaryOpacity70, fontSize: FontSize.s14),

      //gray
      labelLarge: getBoldStyle(color: AppColors.grey, fontSize: FontSize.s20),
      labelMedium:
          getSemiBoldStyle(color: AppColors.grey, fontSize: FontSize.s18),
      labelSmall: getLightStyle(color: AppColors.grey, fontSize: FontSize.s14),

      //white
      headlineLarge:
          getBoldStyle(color: AppColors.white, fontSize: FontSize.s24),
      headlineMedium:
          getMediumStyle(color: AppColors.white, fontSize: FontSize.s18),
      headlineSmall:
          getLightStyle(color: AppColors.white, fontSize: FontSize.s14),
    ),
    // input decoration theme (text form field)

    inputDecorationTheme: InputDecorationTheme(
      iconColor: AppColors.grey,
      contentPadding: const EdgeInsets.only(top: AppPadding.p8),
      hintStyle: getRegularStyle(color: AppColors.grey1),
      labelStyle: getMediumStyle(color: AppColors.darkGrey),
      errorStyle: getRegularStyle(
        color: AppColors.darkError,
      ), // Use dark color for error
    ),
  );
}

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
      elevation: AppSize.s4,
    ),
    // App bar theme
    appBarTheme: AppBarTheme(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.black,
      elevation: 0,
      shadowColor: Colors.white10,
      centerTitle: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
      titleTextStyle:
          getBoldStyle(color: AppColors.black, fontSize: FontSize.s24),
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
        minimumSize: const Size(AppWidth.w255, AppHeight.h50),
        textStyle: getRegularStyle(color: AppColors.white),
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSize.s8,
          ),
        ),
      ),
    ),

    // Text theme
    textTheme: TextTheme(
      //black
      displayLarge:
          getBoldStyle(color: AppColors.black, fontSize: FontSize.s24),
      displayMedium:
          getRegularStyle(color: AppColors.black, fontSize: FontSize.s16),
      displaySmall:
          getSemiBoldStyle(color: AppColors.black, fontSize: FontSize.s16),

      //primary
      titleLarge:
          getBoldStyle(color: AppColors.primary, fontSize: FontSize.s24),
      titleMedium:
          getMediumStyle(color: AppColors.primary, fontSize: FontSize.s18),
      titleSmall:
          getMediumStyle(color: AppColors.primary, fontSize: FontSize.s14),

      //primary with opacity
      bodyLarge: getRegularStyle(
          color: AppColors.primaryOpacity70, fontSize: FontSize.s20),
      bodyMedium: getMediumStyle(
          color: AppColors.primaryOpacity70, fontSize: FontSize.s16),
      bodySmall: getRegularStyle(
          color: AppColors.primaryOpacity70, fontSize: FontSize.s14),

      //gray
      labelLarge: getBoldStyle(color: AppColors.grey, fontSize: FontSize.s20),
      labelMedium:
          getSemiBoldStyle(color: AppColors.grey, fontSize: FontSize.s18),
      labelSmall: getLightStyle(color: AppColors.grey, fontSize: FontSize.s14),

      //white
      headlineLarge:
          getBoldStyle(color: AppColors.white, fontSize: FontSize.s24),
      headlineMedium:
          getMediumStyle(color: AppColors.white, fontSize: FontSize.s18),
      headlineSmall:
          getLightStyle(color: AppColors.white, fontSize: FontSize.s14),
    ),
    // input decoration theme (text form field)

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.only(top: AppPadding.p6),
      // hint style
      hintStyle: getRegularStyle(color: AppColors.grey1),

      // label style
      labelStyle: getMediumStyle(color: AppColors.darkGrey),
      // error style
      errorStyle: getRegularStyle(color: AppColors.error),
    ),
  );
}
