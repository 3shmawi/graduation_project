import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Dimensions {
  static double screenHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  static double screenWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  static double heightPercentage(BuildContext context, double percentage) =>
      screenHeight(context) * percentage / 100;

  static double widthPercentage(BuildContext context, double percentage) =>
      screenWidth(context) * percentage / 100;

  static double fontSize(BuildContext context, double percentage) =>
      screenHeight(context) * percentage / 100;

  static double radius(BuildContext context, double percentage) =>
      screenHeight(context) * percentage / 100;
}

bool isStartWithArabic(String letter) {
  return RegExp(r'^[\u0600-\u06FF]').hasMatch(letter);
}

String daysBetween(DateTime date) {
  if (DateTime.now().difference(date).inDays <= 5) {
    if ((DateTime.now().difference(date).inHours / 24).round() == 0) {
      if (DateTime.now().difference(date).inHours == 0) {
        if (DateTime.now().difference(date).inMinutes == 0) {
          return 'now';
        } else {
          return '${DateTime.now().difference(date).inMinutes.toString()}m';
        }
      } else {
        return '${DateTime.now().difference(date).inHours.toString()}h';
      }
    } else {
      return (' ${(DateTime.now().difference(date).inHours / 24).round().toString()}d');
    }
  } else {
    return formatDate(date.toString());
  }
}

String formatDate(String date) {
  return DateFormat('dd MMMM yyyy').format(
    DateTime.parse(date),
  );
}

String getNumOfLikes(String number) {
  switch (number.length) {
    case 1:
      return number;
    case 2:
      return number;
    case 3:
      return '0.${number[0]}K';
    case 4:
      return '${number[0]}.${number[1]}K';
    case 5:
      return '${number[0]}${number[1]}.${number[2]}K';
    case 6:
      return '${number[0]}${number[1]}${number[2]}.${number[3]}K';
    case 7:
      return '${number[0]}${number[1]}${number[2]}${number[3]}.${number[4]}K';
    case 8:
      return '${number[0]}${number[1]}${number[2]}${number[3]}${number[4]}.${number[5]}K';
    default:
      return number;
  }
}
