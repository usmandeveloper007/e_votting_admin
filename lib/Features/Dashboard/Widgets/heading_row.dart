import 'package:e_voting_admin/Utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadingRow extends StatelessWidget {
  final List<String> headings;
  const HeadingRow({super.key, required this.headings});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 12.w,),
        for(var heading in headings)
          headingContainer(heading),
        SizedBox(width: 10.w,),
      ],
    );
  }

  Widget headingContainer(String title){
    return Expanded(
      child: Center(
        child: Text(title, style: AppStyles.heading3()),
      ),
    );
  }
}
