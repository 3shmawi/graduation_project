import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'font_manager.dart';

// regular style

TextStyle getRegularStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return GoogleFonts.amiri(
    fontWeight: FontWeightManager.regular,
    color: color,
    fontSize: fontSize,
  );
}

// medium style

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return GoogleFonts.amiri(
    fontWeight: FontWeightManager.medium,
    color: color,
    fontSize: fontSize,
  );
}

// medium style

TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return GoogleFonts.amiri(
    fontWeight: FontWeightManager.light,
    color: color,
    fontSize: fontSize,
  );
}

// bold style

TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color}) {
  return GoogleFonts.amiri(
    fontWeight: FontWeightManager.bold,
    color: color,
    fontSize: fontSize,
  );
}

// semi bold style

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return GoogleFonts.amiri(
    fontWeight: FontWeightManager.semiBold,
    color: color,
    fontSize: fontSize,
  );
}
