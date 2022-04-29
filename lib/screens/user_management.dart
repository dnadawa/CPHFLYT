import 'package:cphflyt/constants.dart';
import 'package:cphflyt/controllers/bottom_nav_controller.dart';
import 'package:cphflyt/controllers/user_management_controller.dart';
import 'package:cphflyt/widgets/button.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:cphflyt/widgets/drawer.dart';
import 'package:cphflyt/widgets/input_field.dart';
import 'package:cphflyt/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class UserManagement extends StatelessWidget {

  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userController = Provider.of<UserManagementController>(context);
    var dropDownValue = Provider.of<BottomNavController>(context).dropDownValue;
    bool isDriver = userController.userType == UserType.Driver;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: "User Management", fontSize: 22.sp, isBold: true,color: Colors.white,),
      ),
      drawer: AppDrawer("user-management"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25.w),
          child: Column(
            children: [
              ToggleSwitch(
                initialLabelIndex: isDriver?0:1,
                activeFgColor: Colors.white,
                inactiveBgColor: Color(0xffE6E6E6),
                inactiveFgColor: Color(0xff747474),
                totalSwitches: 2,
                labels: ['Driver', 'Employee'],
                fontSize: 14.sp,
                icons: [Icons.directions_car_filled, Icons.person_pin, Icons.delete],
                activeBgColor: [kLightBlue],
                cornerRadius: 40.r,
                animate: true,
                animationDuration: 200,
                curve: Curves.easeIn,
                minWidth: 110.w,
                onToggle: (index)=>userController.userType = index==0? UserType.Driver: UserType.Employee,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Image.asset(isDriver?"assets/driver.png":"assets/employee.png"),
              ),
              InputField(text: isDriver?"Driver's Name":"Employee's Name", icon: Icons.person,controller: name,),

              if (!isDriver)
                SizedBox(height: 15.h,),
              if (!isDriver)
                Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(width: 2, color: Color(0xffE4DFDF))
                ),
                child: DropdownButton(
                    underline: SizedBox.shrink(),
                    isExpanded: true,
                    hint: Text("Which page need to access?"),
                    value: dropDownValue,
                    items: [
                      DropdownMenuItem(child: CustomText(text: "Website Tasks",align: TextAlign.center,),value: Nav.Website,),
                      DropdownMenuItem(child: CustomText(text: "Manual Tasks"),value: Nav.Manual,),
                    ],
                    onChanged: (Nav? value)=>Provider.of<BottomNavController>(context, listen: false).dropDownValue = value!
                ),
              ),

              SizedBox(height: 15.h,),
              InputField(text: "Email", icon: Icons.email,keyboard: TextInputType.emailAddress,controller: email,),
              SizedBox(height: 15.h,),
              InputField(text: "Password", icon: Icons.lock,isPassword: true,controller: password,),
              SizedBox(height: 15.h,),
              InputField(text: "Confirm Password", icon: Icons.lock, isPassword: true,controller: confirmPassword,),
              SizedBox(height: 50.h,),

              SizedBox(
                width: double.infinity,
                child: Button(
                    color: kLightBlue,
                    text: "Create Account",
                    onPressed: () async {
                      if (name.text.isEmpty || email.text.isEmpty || password.text.isEmpty || (dropDownValue == null && !isDriver)){
                        ToastBar(text: "Please fill all the fields!", color: Colors.red).show();
                      }
                      else if (password.text != confirmPassword.text){
                        ToastBar(text: "Passwords doesn't match!", color: Colors.red).show();
                      }
                      else{
                        ToastBar(text: "Please wait", color: Colors.orange).show();

                         if(await userController.registerUser(name: name.text, email: email.text, password: password.text, type: userController.userType, accessedPage: dropDownValue)){
                           name.clear();
                           email.clear();
                           password.clear();
                           confirmPassword.clear();
                         }
                      }
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
