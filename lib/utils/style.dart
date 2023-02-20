import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yatra/utils/colors.dart';

class Styles {
  static TextTheme data = TextTheme(
    headline1: GoogleFonts.poppins(
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
        color: Colors.black.withOpacity(0.8)),
    bodyText1: GoogleFonts.inter(
        fontSize: 15.sp,
        color: MyColor.blackColor,
        fontWeight: FontWeight.w400),
    headline6: GoogleFonts.inter(fontSize: 18.sp, fontWeight: FontWeight.bold),
    headline3: GoogleFonts.inter(fontSize: 30.sp, fontWeight: FontWeight.bold),
    bodyText2: GoogleFonts.inter(
        fontSize: 18.sp,
        color: MyColor.blackColor,
        fontWeight: FontWeight.w600),
  );
}
