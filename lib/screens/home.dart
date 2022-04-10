import 'package:cphflyt/widgets/bottom_nav_bar.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:cphflyt/widgets/label_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:cphflyt/constants.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: "Home", fontSize: 22.sp, isBold: true,color: Colors.white,),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
              ToggleSwitch(
                initialLabelIndex: 0,
                activeFgColor: Colors.white,
                inactiveBgColor: Color(0xffE6E6E6),
                inactiveFgColor: Color(0xff747474),
                totalSwitches: 3,
                labels: ['Pending', 'Approved', 'Trash'],
                fontSize: 14.sp,
                icons: [Icons.pending_actions, Icons.check_box, Icons.delete],
                activeBgColors: [[Color(0xffE68C36)],[kApproved],[kDeclined]],
                cornerRadius: 40.r,
                animate: true,
                animationDuration: 200,
                curve: Curves.easeIn,
                minWidth: 110.w,
              ),
              SizedBox(height: 30.h,),

              ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r)
                    ),
                    elevation: 7,
                    primary: Colors.white
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Icon(Icons.add_box_rounded, color: kLightBlue,),
                          SizedBox(width: 15.w,),
                          CustomText(text: "Add a New Task",isBold: true,fontSize: 22.sp,)
                      ],
                    ),
                  ),
            ),
            SizedBox(height: 30.h,),

              Card(
                margin: EdgeInsets.only(bottom: 20.h),
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r)
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: LabelInputField(text: "ID"),
                        )
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(right: Radius.circular(15.r)),
                          color: kLightBlue,
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5.w,35.w,5.w,35.w),
                          child: Icon(Icons.arrow_forward, color: Colors.white,),
                        )
                    )
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.only(bottom: 20.h),
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r)
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: LabelInputField(text: "Fornavn"),
                      )
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: LabelInputField(text: "Efternavn"),
                        )
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(right: Radius.circular(15.r)),
                          color: kLightBlue,
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5.w,35.w,5.w,35.w),
                          child: Icon(Icons.arrow_forward, color: Colors.white,),
                        )
                    )
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.only(bottom: 20.h),
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r)
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: LabelInputField(text: "Fornavn"),
                      )
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: LabelInputField(text: "Efternavn"),
                        )
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(right: Radius.circular(15.r)),
                          color: kLightBlue,
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5.w,35.w,5.w,35.w),
                          child: Icon(Icons.arrow_forward, color: Colors.white,),
                        )
                    )
                  ],
                ),
              ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavBar(),
    );
  }
}
