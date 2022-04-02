import 'package:cphflyt/constants.dart';
import 'package:cphflyt/widgets/button.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssignDriver extends StatefulWidget {

  @override
  State<AssignDriver> createState() => _AssignDriverState();
}

class _AssignDriverState extends State<AssignDriver> {
  int? selectedDriver;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r)
      ),
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 35.h),
      content: SizedBox(
        width: 1.sw,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              Container(
                padding: EdgeInsets.all(15.h),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15.r))
                ),
                child: CustomText(
                  text: 'Assign a Driver',
                  color: Colors.white,
                  isBold: true,
                  fontSize: 28.sp,
                  align: TextAlign.center,
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(15.w),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, i){
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                              selectedDriver = i;
                          });
                        },
                        child: Card(
                          elevation: 8,
                          margin: EdgeInsets.only(bottom: 15.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(left: Radius.circular(10.r)),
                                    color: kLightBlue,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(15.w),
                                    child: Visibility(
                                        visible: selectedDriver==i,
                                        maintainAnimation: true,
                                        maintainState: true,
                                        maintainSize: true,
                                        child: Icon(Icons.check_box, color: Colors.white,)
                                    ),
                                  )
                              ),
                              SizedBox(width: 20.w),
                              CustomText(
                                text: "Saman Kumara",
                                fontSize: 18.sp,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(30.w),
                child: Button(
                    color: kApproved,
                    text: "Assign",
                    onPressed: (){}
                ),
              ),
          ],
        ),
      ),
    );
  }
}
