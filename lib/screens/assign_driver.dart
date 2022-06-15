import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cphflyt/constants.dart';
import 'package:cphflyt/controllers/driver_assign_controller.dart';
import 'package:cphflyt/controllers/user_management_controller.dart';
import 'package:cphflyt/models/driver_model.dart';
import 'package:cphflyt/widgets/button.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AssignDriver extends StatelessWidget {

  final String requestID;
  final String? assignedDriverID;

  const AssignDriver({required this.requestID, this.assignedDriverID});

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<DriverAssignController>(context);

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
                  child: FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>(
                    future:  Provider.of<UserManagementController>(context).getDrivers(),
                    builder: (context, snapshot){
                      if (snapshot.hasData){
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, i){

                            Driver driver = controller.createDriverFromDocument(snapshot.data![i]);

                            return GestureDetector(
                              onTap: ()=>controller.selectedDriver = driver.uid,
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
                                              visible: controller.selectedDriver == driver.uid,
                                              maintainAnimation: true,
                                              maintainState: true,
                                              maintainSize: true,
                                              child: Icon(Icons.check_box, color: Colors.white,)
                                          ),
                                        )
                                    ),
                                    SizedBox(width: 20.w),
                                    CustomText(
                                      text: driver.name,
                                      fontSize: 18.sp,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }

                      // select already selected driver
                      if (snapshot.connectionState == ConnectionState.waiting){
                        WidgetsBinding.instance.addPostFrameCallback((_){
                          if (assignedDriverID == null){
                            controller.selectedDriver = null;
                          }
                          else{
                            controller.selectedDriver = assignedDriverID;
                          }
                        });
                      }

                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(30.w),
                child: Button(
                    color: kApproved,
                    text: "Assign",
                    onPressed: ()=>controller.assignDriver(controller.selectedDriver, requestID, context)
                ),
              ),
          ],
        ),
      ),
    );
  }
}
