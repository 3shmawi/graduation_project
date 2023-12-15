import 'package:flutter/material.dart';

class AppColors {
  static Color primary = HexColor.fromHex("#0067DB");
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#F2F4F5");
  static Color primaryOpacity70 = HexColor.fromHex("#B3ED9728");

  // new colors
  static Color darkPrimary = HexColor.fromHex("#d17d11");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color error = HexColor.fromHex("#e61f34");
  static Color black = HexColor.fromHex("#000000"); // red color

//txt
  static Color gradient1 = HexColor.fromHex("#004BAB");
  static Color gradient2 = HexColor.fromHex("#02804D");
  static Color gradient3 = HexColor.fromHex("#03AB00");

  //campaign
  static Color gradient4 = HexColor.fromHex("#3C89F7").withOpacity(.6);
  static Color gradient5 = HexColor.fromHex("#1396C2").withOpacity(.6);

  //dark
  static Color darkBackground = HexColor.fromHex("#121212");
  static Color darkSurface = HexColor.fromHex("#1E1E1E");
  static Color darkAppBarBackground = HexColor.fromHex("#212121");
  static Color darkError = HexColor.fromHex("#CF6679");

}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
