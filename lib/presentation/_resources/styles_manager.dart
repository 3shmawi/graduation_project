import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'font_manager.dart';

// regular style

TextStyle getRobotoRegularStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return GoogleFonts.roboto(
    fontWeight: FontWeightManager.regular,
    color: color,
    fontSize: fontSize,
  );
}

TextStyle getSansitaRegularStyle({
  required Color color,
  double fontSize = FontSize.s12,
}) {
  return GoogleFonts.sansitaSwashed(
    fontWeight: FontWeightManager.regular,
    color: color,
    fontSize: fontSize,
  );
}

// medium style

TextStyle getRobotoMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return GoogleFonts.roboto(
    fontWeight: FontWeightManager.medium,
    color: color,
    fontSize: fontSize,
  );
}

TextStyle getSansitaMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return GoogleFonts.sansitaSwashed(
    fontWeight: FontWeightManager.medium,
    color: color,
    fontSize: fontSize,
  );
}

// medium style

TextStyle getRobotoLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return GoogleFonts.roboto(
    fontWeight: FontWeightManager.light,
    color: color,
    fontSize: fontSize,
  );
}

TextStyle getSansitoLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return GoogleFonts.sansitaSwashed(
    fontWeight: FontWeightManager.light,
    color: color,
    fontSize: fontSize,
  );
}

// bold style

TextStyle getRobotoBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return GoogleFonts.roboto(
    fontWeight: FontWeightManager.bold,
    color: color,
    fontSize: fontSize,
  );
}

TextStyle getSansitoBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return GoogleFonts.sansitaSwashed(
    fontWeight: FontWeightManager.bold,
    color: color,
    fontSize: fontSize,
  );
}

// semi bold style

TextStyle getSansitoSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return GoogleFonts.sansitaSwashed(
    fontWeight: FontWeightManager.semiBold,
    color: color,
    fontSize: fontSize,
  );
}

TextStyle getRobotoSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return GoogleFonts.roboto(
    fontWeight: FontWeightManager.semiBold,
    color: color,
    fontSize: fontSize,
  );
}
