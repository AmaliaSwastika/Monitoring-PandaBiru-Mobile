import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panda_biru/theme/theme_color.dart';

class ThemeTextStyle {
  TextStyle splash  = GoogleFonts.outfit(
    fontSize: 25,
    fontWeight: FontWeight.w600,
    color: ThemeColor().whiteColor,
  );

  TextStyle login  = GoogleFonts.outfit(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: ThemeColor().blueColor,
  );

  TextStyle login2  = GoogleFonts.outfit(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: ThemeColor().grayColor,
  );

  TextStyle buttonLogin  = GoogleFonts.outfit(
    fontSize: 21,
    fontWeight: FontWeight.w600,
    color: ThemeColor().whiteColor,
  );

  TextStyle appBar  = GoogleFonts.outfit(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: ThemeColor().whiteColor,
  );

  TextStyle welcomeUsername  = GoogleFonts.outfit(
    fontSize: 21,
    fontWeight: FontWeight.w600,
    color: ThemeColor().blueColor,
  );

  TextStyle attendance  = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: ThemeColor().whiteColor,
  );

  TextStyle attendanceSuccess  = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: ThemeColor().greenColor,
  );

  TextStyle attendanceSuccess2  = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: ThemeColor().blueColor,
  );

  TextStyle storeName  = GoogleFonts.outfit(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: ThemeColor().blueColor,
  );

  TextStyle storeDetail  = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: ThemeColor().grayColor,
  );

  TextStyle popupPromo  = GoogleFonts.outfit(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: ThemeColor().blueColor,
  );

  TextStyle promoShop  = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: ThemeColor().blueColor,
  );

  TextStyle buttonPromo  = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: ThemeColor().whiteColor,
  );

  TextStyle buttonPromo2  = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: ThemeColor().blueColor,
  );
}