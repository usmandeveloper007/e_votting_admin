import 'package:e_voting_admin/Features/Authentication/Models/user_model.dart';
import 'package:e_voting_admin/Features/Dashboard/Widgets/heading_row.dart';
import 'package:e_voting_admin/Services/firestore_services.dart';
import 'package:e_voting_admin/Utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Controller/dashboard_controller.dart';
import '../../Widgets/page_heading.dart';

class Results extends StatelessWidget {
   Results({Key? key}) : super(key: key);
  final DashboardController controller = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeading(name: "Results"),
          Row(
            children: [
              filterCon("National Assembly"),
              filterCon("Provincial Assembly"),
            ],
          ),
          HeadingRow(headings: ["Image", "Name", "CNIC", "Party Name", "City", "Vote Count"]),
          SizedBox(height: 30.h,),
          Expanded(
            child: StreamBuilder<List<UserModel>>(
              stream: FireStoreServices.getApprovedCandidatesStream(),
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
                            () =>controller.resFilter.value==user.electionType
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
                                contentContainer(data: user.cNIC.toString()),
                                contentContainer(data: user.partType),
                                contentContainer(data: user.city),
                                contentContainer(
                                  child: StreamBuilder<int>(
                                    stream: FireStoreServices.getVoteResultsStream(
                                        canId: user.userId!, electionType: user.electionType!),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return SizedBox();
                                      }
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Center(child: CircularProgressIndicator());
                                      }
                                      int voteCount = snapshot.data ?? 0;
                                      return Center(
                                        child:  Text(voteCount.toString(), style: AppStyles.customStyle(fontWeight: FontWeight.w500, size: 15.sp),),
                                      );
                                    },
                                  ),
                                ),
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
           onTap: ()=> controller.resFilter(title),
           child: Container(
             padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
             decoration:  BoxDecoration(
               borderRadius: BorderRadius.circular(16.r),
               border: Border.all(color: Colors.black),
               color: controller.resFilter.value==title
                   ? Colors.black
                   : Colors.white,
             ),
             child: Text(
               title,
               style: AppStyles.customStyle(
                 fontWeight: FontWeight.w600,
                 size: 18.sp,
                 color: controller.resFilter.value==title
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
