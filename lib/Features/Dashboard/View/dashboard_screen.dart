import 'package:e_voting_admin/Services/auth_services.dart';
import 'package:e_voting_admin/Utils/app_colors.dart';
import 'package:e_voting_admin/Utils/app_styles.dart';
import 'package:e_voting_admin/Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tab_container/tab_container.dart';

import 'Screens/candidates.dart';
import 'Screens/election.dart';
import 'Screens/results.dart';
import 'Screens/voters.dart';


class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            TabContainer(
              tabEdge:TabEdge.left,
              tabStart: 0.2,
              tabEnd: 0.6,
              tabExtent: 250.w,
              tabCurve: Curves.easeInExpo,
              selectedTextStyle: AppStyles.customStyle(
                fontWeight: FontWeight.w800, size: 21.sp, color: Colors.black,
              ),
              unselectedTextStyle: AppStyles.customStyle(
                fontWeight: FontWeight.w500, size: 18.sp, color: Colors.white,
              ),
              color: Colors.white,
              children: [
                Election(),
                Candidates(),
                Voters(),
                Results(),
              ],
              tabs: const [
                'Election',
                'Candidates',
                'Voters',
                'Results',
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                  height: 100.h, width: 250.w,
                  child: CustomButton(
                      color: Colors.black,
                      onTap: (){
                        AuthServices.logout();
                        Get.offAllNamed("/login");
                      },
                      name: "Log Out")),
            )
          ],
        )
      ),
    );
  }
}


