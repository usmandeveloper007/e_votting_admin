import 'package:e_voting_admin/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Utils/app_styles.dart';
import 'custom_button.dart';

customDialog(BuildContext context, String title, String subtitle){
  showDialog(
    context: context,
    barrierColor: Colors.grey.withOpacity(0.1),
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: 354.h, width: 354.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: AppColors.primaryBg,
          ),
          child: Column(
            children: [

              SizedBox(height: 20.h,),
              Text(title, textAlign: TextAlign.center, style: AppStyles.dialogContentStyle(fontWeight: FontWeight.w700, size: 34.sp),),
              SizedBox(height: 50.h,),
              Text(subtitle, textAlign: TextAlign.center,
                style: AppStyles.dialogContentStyle(fontWeight: FontWeight.w700, size: 14.sp),
              ),
              SizedBox(height: 50.h,),
              SizedBox(
                  width: 150.w,
                  child: CustomButton(name: "Okay", onTap: (){
                    Navigator.pop(context);
                  },))
            ],
          ),
        ),
      );
    },
  );
}

