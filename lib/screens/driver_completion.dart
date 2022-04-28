import 'package:cphflyt/widgets/button.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:cphflyt/widgets/drawer.dart';
import 'package:cphflyt/widgets/label_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

class DriverCompletion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: "Home", fontSize: 22.sp, isBold: true,color: Colors.white,),
      ),
      drawer: AppDrawer("home"),
      body: Card(
          color: Color(0xffFAFAFA),
          margin: EdgeInsets.all(20.w),
          elevation: 8,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r)
          ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Opgave nummer"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Dato"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Start tidspunkt"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Slut tidspunkt"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Timepris"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Antal timer"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Betalingstype"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Tungløft"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Skrald"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Opbevaring"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: LabelInputField(text: "Samlet beløb"),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25.h),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                          color: Color(0xff0D47A1),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.h),
                          child: Text(
                            "Vedhæft 1",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        width: double.infinity,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
                        border: Border.all(color: Color(0xff0D47A1), width: 4),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xffE0E0E0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 3,
                                    offset: Offset(1,1)
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 40.w),
                              child: Text("Choose File"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25.h),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                          color: Color(0xff0D47A1),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.h),
                          child: Text(
                            "Vedhæft 2",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        width: double.infinity,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
                        border: Border.all(color: Color(0xff0D47A1), width: 4),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xffE0E0E0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 3,
                                    offset: Offset(1,1)
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 40.w),
                              child: Text("Choose File"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25.h),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                          color: Color(0xff0D47A1),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.h),
                          child: Text(
                            "Vedhæft 3",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        width: double.infinity,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
                        border: Border.all(color: Color(0xff0D47A1), width: 4),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xffE0E0E0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 3,
                                    offset: Offset(1,1)
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 40.w),
                              child: Text("Choose File"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25.h),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                          color: Color(0xff0D47A1),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.h),
                          child: Text(
                            "Vedhæft 4",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        width: double.infinity,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
                        border: Border.all(color: Color(0xff0D47A1), width: 4),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xffE0E0E0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 3,
                                    offset: Offset(1,1)
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 40.w),
                              child: Text("Choose File"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25.h),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                          color: Color(0xff0D47A1),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.h),
                          child: Text(
                            "Vedhæft 5",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        width: double.infinity,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
                        border: Border.all(color: Color(0xff0D47A1), width: 4),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xffE0E0E0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 3,
                                    offset: Offset(1,1)
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 40.w),
                              child: Text("Choose File"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25.h),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                          color: Color(0xff0D47A1),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.h),
                          child: Text(
                            "Vedhæft 6",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        width: double.infinity,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
                        border: Border.all(color: Color(0xff0D47A1), width: 4),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xffE0E0E0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 3,
                                    offset: Offset(1,1)
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 40.w),
                              child: Text("Choose File"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25.h),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                          color: Color(0xff0D47A1),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.h),
                          child: Text(
                            "Vedhæft 7",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        width: double.infinity,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
                        border: Border.all(color: Color(0xff0D47A1), width: 4),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xffE0E0E0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 3,
                                    offset: Offset(1,1)
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 40.w),
                              child: Text("Choose File"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25.h),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                          color: Color(0xff0D47A1),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.h),
                          child: Text(
                            "Vedhæft 8",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        width: double.infinity,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
                        border: Border.all(color: Color(0xff0D47A1), width: 4),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xffE0E0E0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 3,
                                    offset: Offset(1,1)
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 40.w),
                              child: Text("Choose File"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: Container(
                    margin: EdgeInsets.all(6.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                            spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 20.w),
                      child: Column(
                        children: [
                          LabelInputField(text: "Medarbejders Navn"),
                          SizedBox(
                            height: 30.h,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xff2FA4FF),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 3,
                                    offset: Offset(1,1)
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 40.w),
                              child: Center(
                                  child: Text("Medarbejders Underskrift",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: Container(
                    margin: EdgeInsets.all(6.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                            spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 20.w),
                      child: Column(
                        children: [
                          LabelInputField(text: "Kundens Navn"),
                          SizedBox(
                            height: 30.h,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xff2FA4FF),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 3,
                                    offset: Offset(1,1)
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 40.w),
                              child: Center(
                                  child: Text("Kundens Underskrift",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 45.h),
                  child: SizedBox(
                      width: double.infinity,
                      child: Button(
                        color: kApproved,
                        text: "Submit",
                        onPressed: () {},
                      )
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
