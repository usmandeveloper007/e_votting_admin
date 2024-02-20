import 'package:e_voting_admin/Features/Dashboard/Model/election_model.dart';
import 'package:e_voting_admin/Services/firestore_services.dart';
import 'package:e_voting_admin/Utils/app_styles.dart';
import 'package:e_voting_admin/Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Controller/dashboard_controller.dart';
import '../../Model/city_party_model.dart';
import '../../Widgets/date_picker.dart';
import '../../Widgets/page_heading.dart';
import '../../Widgets/time_picker.dart';

class Election extends StatelessWidget {
   Election({Key? key}) : super(key: key);
  final DashboardController controller = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, height: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageHeading(name: "Election", trailing: resetButton()),

            FutureBuilder(
              future: FireStoreServices.getCityPartyNameStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final CityPartyModel? names = snapshot.data;
                controller.cityNameList.value=names?.cities ?? [];
                controller.partyNameList.value=names?.parties ?? [];
                return  Row(
                  children: [
                    SizedBox(width: 50.w,),
                    cityPartyBox(
                        title: "City Name",
                        controller: controller.cityNameCont,
                        list: controller.cityNameList,
                        onAdd: ()=> controller.addCityName(),
                        onDelete: (name)=> controller.deleteCityName(name)
                    ),
                    SizedBox(width: 60.w,),
                    cityPartyBox(
                        title: "Party Name",
                        controller: controller.partyNameCont,
                        list: controller.partyNameList,
                        onAdd: ()=> controller.addPartyName(),
                        onDelete: (name)=> controller.deletePartyName(name)
                    ),
                    SizedBox(width: 50.w,),
                  ],
                );
              },
            ),
            SizedBox(height: 90.h,),
            SizedBox(height: 750.h,
              child: StreamBuilder<List<ElectionModel>>(
                stream: FireStoreServices.getElectionStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  // if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                  //   return Center(child: CircularProgressIndicator());
                  // }
                  final List<ElectionModel> elections = snapshot.data ?? [];
                  controller.distributeElectionData(elections);
                  return  Row(
                    children: [
                      SizedBox(width: 50.w,),
                      electionBox(title: "National Assembly", date: controller.nADate,
                          startTime: controller.nAStartTime, endTime: controller.nAEndTime),
                      SizedBox(width: 60.w,),
                      electionBox(title: "Provincial Assembly", date: controller.pADate,
                          startTime: controller.pAStartTime, endTime: controller.pAEndTime),
                      SizedBox(width: 50.w,),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 100.h,),
          ],
        ),
      ),
    );
  }

  Widget cityPartyBox({
     required String title,
    required TextEditingController controller,
    required RxList<String> list,
    required Function() onAdd,
    required Function(String) onDelete,
}){
    return Expanded(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(18.r)
          ),
          child: Column(
            children: [
              Text(title, style: AppStyles.customStyle(
                color: Colors.white, size: 26.sp,
                fontWeight: FontWeight.w600,
              ),),
              SizedBox(height: 50.h,),
              Obx(
                ()=> GridView.builder(
                  itemCount: list.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 7,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 5,
                  ),
                  itemBuilder: (BuildContext context, int index){
                    return Row(
                      children: [
                        Expanded(
                          child: Text(list[index], maxLines: 1, style: AppStyles.customStyle(
                              fontWeight: FontWeight.w500, size: 17.sp, color: Colors.white
                          )),
                        ),
                        SizedBox(width: 10.w),
                        InkWell(
                          onTap: ()=> onDelete(list[index]),
                          borderRadius: BorderRadius.circular(100.r),
                          child: CircleAvatar(
                            radius: 8.sp,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.close, color: Colors.black, size: 12.sp),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h,),
              TextFormField(
                controller: controller,
                style: AppStyles.customStyle(
                  color: Colors.black, size: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: "Enter name",
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                ),
              ),
              SizedBox(height: 30.h,),
              InkWell(
                onTap: ()=> onAdd(),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 70.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.r),
                    color: Colors.white,
                  ),
                  child: Text(
                    "Add",
                    style: AppStyles.customStyle(
                      color: Colors.black, size: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          )
      ),
    );
  }

  Widget electionBox({
    required String title,
    required Rxn<String> date,
    required Rxn<String> startTime,
    required Rxn<String> endTime,
}) {
    return Expanded(
        child: Container(
          // height: 600.h,
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(26.r)
          ),
          child: Column(
            children: [
              Text(title, style: AppStyles.customStyle(
                color: Colors.white, size: 26.sp,
                fontWeight: FontWeight.w600,
              ),),
              SizedBox(height: 50.h,),
              timeCard("Voting Date", date, true),
              SizedBox(height: 35.h,),
              timeCard("Start Time", startTime, false),
              SizedBox(height: 35.h,),
              timeCard("End Time", endTime, false),
              Spacer(),
              InkWell(
                onTap: ()=> controller.setOrUpdateTime(
                    type: title, date: date.value,
                    startTime: startTime.value, endTime: endTime.value),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 70.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.r),
                    color: Colors.white,
                  ),
                  child: Text(
                    "Save",
                    style: AppStyles.customStyle(
                      color: Colors.black, size: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }

  Widget timeCard(String key, Rxn<String> timeController, bool isDate){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(key, style: AppStyles.customStyle(
          color: Colors.white, size: 18.sp,
          fontWeight: FontWeight.w600,
        ),),
        SizedBox(height: 20.h,),
        InkWell(
          onTap: ()=> isDate
              ? datePicker(Get.context!, timeController)
              : timePicker(Get.context!, timeController),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 35.w),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              color: Colors.white,
            ),
            child: Obx(
              ()=> Text(
                timeController.value ?? "",
                style: AppStyles.customStyle(
                  color: Colors.black, size: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget resetButton() {
    return SizedBox(
      width: 220.w,
      height: 70.h,
      child: Obx(
          ()=> controller.loader.value
              ? Center(child: CircularProgressIndicator())
              : CustomButton(name: "Reset Election Data",
        onTap: ()=> controller.deleteAllElectionData()
        ),
      ),
    );
  }
}
