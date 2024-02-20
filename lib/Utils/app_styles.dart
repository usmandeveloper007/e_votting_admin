
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppStyles {

  static TextStyle primaryHeading(){
    return GoogleFonts.roboto(
      textStyle: TextStyle(
          color: AppColors.primaryTextColor,
          fontWeight: FontWeight.w700,
          fontSize: 46.sp,
          letterSpacing: .5
      ),
    );
  }
  static TextStyle dashboardPrimaryHeading(){
    return GoogleFonts.manrope(
      textStyle: TextStyle(
          color: AppColors.primaryTextColor,
          fontWeight: FontWeight.w700,
          fontSize: 40.sp,
          letterSpacing: .3
      ),
    );
  }

  static TextStyle logoHeading(){
    return GoogleFonts.roboto(
      textStyle: TextStyle(
          color: AppColors.primaryTextColor,
          fontWeight: FontWeight.w700,
          fontSize: 24.sp,
          letterSpacing: .5
      ),
    );
  }

  static TextStyle heading2(){
    return GoogleFonts.roboto(
      textStyle: TextStyle(
          color: AppColors.primaryTextColor,
          fontWeight: FontWeight.w500,
          fontSize: 24.sp,
          letterSpacing: .5
      ),
    );
  }

  static TextStyle heading3(){
    return GoogleFonts.roboto(
      textStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 16.sp,
      ),
    );
  }



  static TextStyle tabBarStyle({FontWeight? fontWeight}){
    return GoogleFonts.roboto(
      textStyle: TextStyle(
          color: AppColors.indicatorColor,
          fontWeight: fontWeight ?? FontWeight.w500,
          fontSize: 28.sp,
      ),
    );
  }

  static TextStyle customStyle({FontWeight? fontWeight, double? size, Color? color}){
    return GoogleFonts.inter(
      textStyle: TextStyle(
        color: color ?? const Color(0xff000000),
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize:size ?? 14.sp,
      ),
    );
  }

  static TextStyle dialogContentStyle({FontWeight? fontWeight, double? size}){
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        color: const Color(0xff000000),
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize:size ?? 20.sp,
      ),
    );
  }



}