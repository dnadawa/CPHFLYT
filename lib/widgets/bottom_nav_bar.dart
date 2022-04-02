import 'package:cphflyt/constants.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){
                setState(() {
                  selectedIndex = 0;
                });
            },
            child: Container(
              color: selectedIndex==0?kLightBlue:Colors.white,
              child: Padding(
                padding: EdgeInsets.all(7.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.dynamic_feed,size: 25.h,color: selectedIndex==0?Colors.white:Theme.of(context).primaryColor,),
                    SizedBox(width: 15.w,),
                    CustomText(text: "Website\nTasks",fontSize: 18.sp,color: selectedIndex==0?Colors.white:Theme.of(context).primaryColor,)
                  ],
                ),
              ),
            ),
          ),
        ),

        Expanded(
          child: GestureDetector(
            onTap: (){
              setState(() {
                selectedIndex = 1;
              });
            },
            child: Container(
              color: selectedIndex==1?kLightBlue:Colors.white,
              child: Padding(
                padding: EdgeInsets.all(7.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.create_new_folder_outlined,size: 25.h,color: selectedIndex==1?Colors.white:Theme.of(context).primaryColor,),
                    SizedBox(width: 15.w,),
                    CustomText(text: "Manual\nTasks",fontSize: 18.sp,color: selectedIndex==1?Colors.white:Theme.of(context).primaryColor,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
