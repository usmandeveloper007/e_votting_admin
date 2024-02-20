import 'package:e_voting_admin/Utils/app_styles.dart';
import 'package:e_voting_admin/Widgets/custom_button.dart';
import 'package:e_voting_admin/Widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Services/auth_services.dart';
import '../../../Utils/app_assets.dart';
import '../../../Utils/app_colors.dart';
import '../../Dashboard/View/dashboard_screen.dart';
import '../Widgets/custom_text_field.dart';


class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      body: Container(
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: 510.w,
              color: AppColors.loginBg,
              child: Center(
                child: Image.asset(AppAssets.appLogo, height: 100.h, width: 100.w,),
              ),
            ),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 160.h,
                  width: 180.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: AppColors.loginBg,
                  ),
                  child: Center(
                    child: Image.asset(AppAssets.appLogo, height: 100.h, width: 100.w,),
                  ),
                ),
                SizedBox(height: 60.h,),
                Text("Admin Panel", style: AppStyles.primaryHeading(),),
                SizedBox(height: 100.h,),
                CustomTextField(controller: email, hint:  "Email",),
                SizedBox(height: 60.h,),
                CustomTextField(controller: password, hint:  "Password",),
                SizedBox(height: 100.h,),
                // CustomButton(name: AppStrings.logIn, onTap: ()=> context.go('/dashboard'),),
                CustomButton(name: "Login", onTap: () async {
                  if(email.text.isNotEmpty && password.text.length>5){
                    try{
                      if(email.text != "admin@voting.com"){
                        throw "User not found with this email";
                      }
                      await AuthServices.login(email.text, password.text).then((value){
                        if(value){
                          Get.offAllNamed("/dashboard");
                        }
                      });
                    } catch (error){
                      customDialog(context, "Log In\nFailed", error.toString());
                      print(error);
                    }
                  }
                },),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
