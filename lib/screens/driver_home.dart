import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cphflyt/controllers/bottom_nav_controller.dart';
import 'package:cphflyt/controllers/driver_controller.dart';
import 'package:cphflyt/controllers/filter_controller.dart';
import 'package:cphflyt/controllers/user_management_controller.dart';
import 'package:cphflyt/models/request_model.dart';
import 'package:cphflyt/screens/details.dart';
import 'package:cphflyt/services/database_service.dart';
import 'package:cphflyt/widgets/bottom_nav_bar.dart';
import 'package:cphflyt/widgets/button.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:cphflyt/widgets/drawer.dart';
import 'package:cphflyt/widgets/label_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:cphflyt/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var databaseService = Provider.of<DatabaseService>(context);
    var navController = Provider.of<BottomNavController>(context);
    var filterController = Provider.of<FilterController>(context);
    var driverController = Provider.of<DriverController>(context);
    var userManagement = Provider.of<UserManagementController>(context);


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: "Home", fontSize: 22.sp, isBold: true,color: Colors.white,),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: driverController.getRequests(userManagement.loggedInDriver?.uid ?? ''),
          builder: (BuildContext context, snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, i){

                  RequestModel request = databaseService.createRequestFromJson(snapshot.data?.docs[i]);
                  final TextEditingController controller = TextEditingController();
                  controller.text = request.fromAddress.getAddressAsString();

                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => Details(request: request)),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.only(bottom: 20.h),
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r)
                      ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 10.h),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                                      child: LabelInputField(
                                        text: "Hvor skal du flytte fra?",
                                        controller: controller,
                                        maxLines: null,
                                      ),
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


                            SizedBox(height: 10.h,),
                            ///maps button
                            Button(
                                color: Colors.green,
                                text: "View on Google map",
                                onPressed: () async {
                                  Uri url = Uri.parse("https://www.google.com/maps/search/?api=1&query=${request.fromAddress.address} ${request.fromAddress.zip} ${request.fromAddress.by}");
                                  await launchUrl(url, mode: LaunchMode.externalNonBrowserApplication);
                            })
                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
          },
        ),
      ),
    );
  }
}
