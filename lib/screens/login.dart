import 'package:cphflyt/constants.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:cphflyt/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
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
                child: Image.asset('assets/login.png'),
              ),

              ///email
              Padding(
                padding: EdgeInsets.fromLTRB(35.w, 90.h, 35.w, 20.h),
                child: InputField(text: 'Email', icon: Icons.email,keyboard: TextInputType.emailAddress,),
              ),

              ///password
              Padding(
                padding: EdgeInsets.fromLTRB(35.w, 0, 35.w, 20.h),
                child: InputField(text: 'Password', icon: Icons.lock, isPassword: true,),
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
                  onPressed: (){},
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
