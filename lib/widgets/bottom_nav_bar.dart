import 'package:cphflyt/controllers/bottom_nav_controller.dart';
import 'package:cphflyt/constants.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var controller = Provider.of<BottomNavController>(context);

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){
                controller.setSelectedNavItem(Nav.Website);
            },
            child: Container(
              color: controller.getSelectedNavItem()==Nav.Website?kLightBlue:Colors.white,
              child: Padding(
                padding: EdgeInsets.all(7.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.dynamic_feed,size: 25.h,color: controller.getSelectedNavItem()==Nav.Website?Colors.white:Theme.of(context).primaryColor,),
                    SizedBox(width: 15.w,),
                    CustomText(text: "Website\nTasks",fontSize: 18.sp,color: controller.getSelectedNavItem()==Nav.Website?Colors.white:Theme.of(context).primaryColor,)
                  ],
                ),
              ),
            ),
          ),
        ),

        Expanded(
          child: GestureDetector(
            onTap: (){
              controller.setSelectedNavItem(Nav.Manual);
            },
            child: Container(
              color: controller.getSelectedNavItem()==Nav.Manual?kLightBlue:Colors.white,
              child: Padding(
                padding: EdgeInsets.all(7.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.create_new_folder_outlined,size: 25.h,color: controller.getSelectedNavItem()==Nav.Manual?Colors.white:Theme.of(context).primaryColor,),
                    SizedBox(width: 15.w,),
                    CustomText(text: "Manual\nTasks",fontSize: 18.sp,color: controller.getSelectedNavItem()==Nav.Manual?Colors.white:Theme.of(context).primaryColor,)
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
