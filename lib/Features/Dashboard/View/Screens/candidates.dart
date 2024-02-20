import 'package:e_voting_admin/Services/firestore_services.dart';
import 'package:e_voting_admin/Utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Authentication/Models/user_model.dart';
import '../../Controller/dashboard_controller.dart';
import '../../Widgets/heading_row.dart';
import '../../Widgets/page_heading.dart';

class Candidates extends StatelessWidget {
   Candidates({Key? key}) : super(key: key);
   final DashboardController controller = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeading(name: "Candidates"),
          Row(
            children: [
              filterCon("National Assembly"),
              filterCon("Provincial Assembly"),
            ],
          ),
          HeadingRow(headings: ["Image", "Full Name", "Date Of Birth", "Email", "City",  "CNIC", "Party Name", "Status"],),
          SizedBox(height: 30.h,),
          Expanded(
            child: StreamBuilder<List<UserModel>>(
              stream: FireStoreServices.getCandidatesStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final List<UserModel> users = snapshot.data ?? [];
                print(users.length);
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final UserModel user = users[index];
                    return Obx(
                            () => controller.canFilter.value==user.electionType
                                ? Row(
                              children: [
                                SizedBox(width: 12.w,),
                                contentContainer(child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100.r),
                                    child: Image.network(user.imageUrl ?? "",
                                      errorBuilder: (BuildContext context, Object exception,
                                          StackTrace? stackTrace) {return const Text('😢');},
                                      height: 50.w, width: 50.w, fit: BoxFit.cover,
                                    ))),
                                contentContainer(data: user.fullName),
                                contentContainer(data: user.age.toString()),
                                contentContainer(data: user.email),
                                contentContainer(data: user.city),
                                contentContainer(data: user.cNIC.toString()),
                                contentContainer(data: user.partType),
                                contentContainer(child: InkWell(
                                  onTap: ()=> FireStoreServices.updateCandidateStatus(
                                      uId: user.userId!,
                                      approved: user.isApproved
                                  ),
                                  borderRadius: BorderRadius.circular(50.r),
                                  child: Container(
                                    width: double.infinity,
                                    height: 50.h,
                                    margin: EdgeInsets.only(left: 10.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.r),
                                      color: user.isApproved==true
                                          ? Colors.black
                                          : Colors.red,
                                    ),
                                    child: Center(
                                      child: Text(
                                        user.isApproved==true
                                            ? "Approved"
                                            : "Not Approved",
                                        style: AppStyles.customStyle(fontWeight: FontWeight.w500, size: 12.sp, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )),
                                SizedBox(width: 10.w,),
                              ],
                            )
                                : SizedBox()
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget filterCon(String title){
    return Obx(
        ()=> Padding(
          padding: EdgeInsets.only(left: 50.w, bottom: 40.h),
          child: InkWell(
            onTap: ()=> controller.canFilter(title),
            child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.black),
              color: controller.canFilter.value==title
                  ? Colors.black
                  : Colors.white,
            ),
            child: Text(
              title,
              style: AppStyles.customStyle(
                fontWeight: FontWeight.w600,
                size: 18.sp,
                color: controller.canFilter.value==title
                    ? Colors.white
                    : Colors.black,
              ),
            ),
      ),
          ),
        ),
    );
  }

  Widget contentContainer({Widget? child, String? data}){
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Center(
          child: child ?? Text(data ?? "N/A", style: AppStyles.customStyle(fontWeight: FontWeight.w500, size: 15.sp),),
        ),
      ),
    );
  }
}
