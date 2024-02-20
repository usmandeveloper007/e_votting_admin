import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const CustomTextField({super.key, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 580.w,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.roboto(
            fontSize: 20.sp, fontWeight: FontWeight.w400,
            color: AppColors.hintColor,
          ),
          // border: OutlineInputBorder(
          //   borderSide: BorderSide(
          //     color: AppColors.borderColor,
          //   )
          // )
        ),
      ),
    );
  }
}
