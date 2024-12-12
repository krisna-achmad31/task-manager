import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle baseTextStyle({
    double fontSize = 14,
    FontWeight? fontWeight,
    double height = 1.0,
    Color color = Colors.black,
  }) {
    return GoogleFonts.lexendDeca(fontSize: fontSize, fontWeight: fontWeight, height: 1.0, color: color);
  }
}

const double defaultPadding24 = 24.0;
const double defaultPadding16 = 16.0;
const double defaultPadding14 = 14.0;
const double defaultPadding12 = 12.0;

const double defBorderRadius = 10.0;