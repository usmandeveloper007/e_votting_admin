import 'package:e_voting_admin/Utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../Services/firestore_services.dart';
import '../../../Authentication/Models/user_model.dart';
import '../../Widgets/heading_row.dart';
import '../../Widgets/page_heading.dart';

class Voters extends StatelessWidget {
  const Voters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeading(name: "Voters"),
          HeadingRow(headings: ["Full Name", "Date Of Birth", "Email", "CNIC", "City", "Address", "Status"]),
          SizedBox(height: 30.h,),
          Expanded(
            child: StreamBuilder<List<UserModel>>(
              stream: FireStoreServices.getVotersStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
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
                    return Row(
                      children: [
                        SizedBox(width: 12.w,),
                        contentContainer(data: user.fullName),
                        contentContainer(data: user.age.toString()),
                        contentContainer(data: user.email),
                        contentContainer(data: user.cNIC.toString()),
                        contentContainer(data: user.city),
                        contentContainer(data: user.address),
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
