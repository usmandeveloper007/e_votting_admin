import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final Function()? onTap;
  final Color? color;

   CustomButton({super.key, required this.name, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60.h,
        width: 326.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: color ?? AppColors.primaryButtonColor,
        ),
        child: Center(
          child: Text(name, style: GoogleFonts.manrope(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
          ),),
        ),
      ),
    );
  }
}
