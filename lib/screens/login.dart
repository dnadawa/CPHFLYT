import 'package:cphflyt/constants.dart';
import 'package:cphflyt/controllers/bottom_nav_controller.dart';
import 'package:cphflyt/controllers/user_management_controller.dart';
import 'package:cphflyt/services/auth_service.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:cphflyt/widgets/input_field.dart';
import 'package:cphflyt/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Login extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userController = Provider.of<UserManagementController>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff5897C3),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ///logo
              Container(
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))
                ),
                child: Image.asset('assets/logo.png'),
              ),

              ///login image
              Padding(
                padding: EdgeInsets.only(top: 55.h),
                child: Image.asset(userController.loginSelector == UserType.SuperAdmin?'assets/login_admin.png':'assets/login_driver.png'),
              ),

              SizedBox(height: 45.h),
              ///switch
              ToggleSwitch(
                initialLabelIndex: userController.loginSelector == UserType.SuperAdmin?0:1,
                activeFgColor: Colors.white,
                inactiveBgColor: Color(0xffE6E6E6),
                inactiveFgColor: Color(0xff747474),
                totalSwitches: 2,
                labels: ['ADMIN LOGIN', 'DRIVER LOGIN'],
                fontSize: 14.sp,
                activeBgColor: [Theme.of(context).primaryColor],
                cornerRadius: 5.r,
                animate: true,
                animationDuration: 200,
                borderWidth: 5,
                borderColor: [Colors.white],
                curve: Curves.easeIn,
                customWidths: [120.w, 120.w],
                onToggle: (index) async {
                  if (index==0){
                    userController.loginSelector = UserType.SuperAdmin;
                  }
                  else {
                    userController.loginSelector = UserType.Driver;
                  }
                },
              ),


              ///email
              Padding(
                padding: EdgeInsets.fromLTRB(35.w, 45.h, 35.w, 20.h),
                child: InputField(
                  text: 'Email',
                  icon: Icons.email,
                  keyboard: TextInputType.emailAddress,
                  isBorder: false,
                  controller: email,
                ),
              ),

              ///password
              Padding(
                padding: EdgeInsets.fromLTRB(35.w, 0, 35.w, 20.h),
                child: InputField(
                  text: 'Password',
                  icon: Icons.lock,
                  isPassword: true,
                  isBorder: false,
                  controller: password,
                ),
              ),

              ///login button
              Padding(
                padding: EdgeInsets.all(60.w),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: EdgeInsets.zero,
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.r)
                    )
                  ),
                  onPressed: (){
                    if (email.text.isNotEmpty && password.text.isNotEmpty) {
                        ToastBar(text: "Please wait", color: Colors.orange).show();
                        Provider.of<AuthService>(context, listen: false).signIn(
                            email.text,
                            password.text,
                            context,
                            Provider.of<UserManagementController>(context, listen: false),
                            Provider.of<BottomNavController>(context, listen: false),
                            isDriver: userController.loginSelector == UserType.Driver
                        );
                    }
                    else{
                      ToastBar(text: "Please fill all the fields!", color: Colors.red).show();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///invisible icon
                      Padding(
                        padding: EdgeInsets.all(15.w),
                        child: Icon(Icons.exit_to_app, color: Colors.white,),
                      ),

                      ///text
                      CustomText(text: "LOGIN",isBold: true,fontSize: 18.sp,),

                      ///icon
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(right: Radius.circular(40.r)),
                          color: kLightBlue,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15.w),
                          child: Icon(Icons.exit_to_app, color: Colors.white,),
                        )
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
