import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static TextStyle get display => GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
  );

  static TextStyle get h1 =>
      GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700);

  static TextStyle get h2 =>
      GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700);

  static TextStyle get bodyLarge =>
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400);

  static TextStyle get body =>
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500);

  static TextStyle get button => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.0,
  );
}
