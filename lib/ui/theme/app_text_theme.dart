import 'package:dayaway_partner/ui/theme/font_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  const AppTextTheme._({
    required this.h10,
    required this.h20,
    required this.h30,
    required this.h40,
    required this.h50,
    required this.h60,
    required this.h70,
    required this.h80,
  });

  factory AppTextTheme({required defaultTextColor}) {
    final _normalRegular = TextStyle(
      fontWeight: FontWeight.w400,
      height: 1.3,
      leadingDistribution: TextLeadingDistribution.even,
      color: defaultTextColor,
    );

    return AppTextTheme._(
      h10: GoogleFonts.poppins(
          textStyle:
              const TextStyle(fontSize: FontSize.pt10).merge(_normalRegular)),
      h20: GoogleFonts.poppins(
          textStyle:
              const TextStyle(fontSize: FontSize.pt12).merge(_normalRegular)),
      h30: GoogleFonts.poppins(
          textStyle:
              const TextStyle(fontSize: FontSize.pt14).merge(_normalRegular)),
      h40: GoogleFonts.poppins(
          textStyle:
              const TextStyle(fontSize: FontSize.pt16).merge(_normalRegular)),
      h50: GoogleFonts.poppins(
          textStyle:
              const TextStyle(fontSize: FontSize.pt20).merge(_normalRegular)),
      h60: GoogleFonts.poppins(
          textStyle:
              const TextStyle(fontSize: FontSize.pt24).merge(_normalRegular)),
      h70: GoogleFonts.poppins(
          textStyle:
              const TextStyle(fontSize: FontSize.pt32).merge(_normalRegular)),
      h80: GoogleFonts.poppins(
          textStyle:
              const TextStyle(fontSize: FontSize.pt40).merge(_normalRegular)),
    );
  }

  /// pt10
  final TextStyle h10;

  /// pt12
  final TextStyle h20;

  /// pt14
  final TextStyle h30;

  /// pt16
  final TextStyle h40;

  /// pt20
  final TextStyle h50;

  /// pt24
  final TextStyle h60;

  /// pt32
  final TextStyle h70;

  /// pt40
  final TextStyle h80;
}

extension TextStyleExt on TextStyle {
  TextStyle bold() => copyWith(fontWeight: FontWeight.w700);

  TextStyle comfort() => copyWith(height: 1.8);

  TextStyle dense() => copyWith(height: 1.2);

  TextStyle cormarant() => GoogleFonts.cormorant(textStyle: this);
}
