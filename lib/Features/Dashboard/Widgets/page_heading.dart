import 'package:e_voting_admin/Utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageHeading extends StatelessWidget {
  final String name;
  final Widget? trailing;

  const PageHeading({super.key, required this.name, this.trailing});
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity, height: 160.h,
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
      margin: EdgeInsets.only(bottom: 50.h),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 5,
                spreadRadius: 5,
                offset: Offset(0, 5)
            )
          ]
      ),
      child: Row(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              name,
              style: AppStyles.dashboardPrimaryHeading(),
            ),
          ),
          trailing!=null
              ? Expanded(
                child: Align(
            alignment: Alignment.bottomRight,
            child: trailing
          ),
              )
              : SizedBox(),
        ],
      )
    );
  }
}
