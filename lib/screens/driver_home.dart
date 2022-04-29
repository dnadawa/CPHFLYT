import 'package:cphflyt/controllers/driver_controller.dart';
import 'package:cphflyt/controllers/user_management_controller.dart';
import 'package:cphflyt/models/request_model.dart';
import 'package:cphflyt/screens/details.dart';
import 'package:cphflyt/services/auth_service.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:cphflyt/widgets/label_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:cphflyt/constants.dart';
import 'package:cphflyt/wrapper.dart';

class DriverHome extends StatefulWidget {
  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  @override
  Widget build(BuildContext context) {
    var driverController = Provider.of<DriverController>(context);
    var userManagement = Provider.of<UserManagementController>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: "Home", fontSize: 22.sp, isBold: true,color: Colors.white,),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: (){
            Provider.of<AuthService>(context, listen: false).signOut();
            Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) =>
                Wrapper()), (Route<dynamic> route) => false);
          },
        ),
      ),
      body: StatefulBuilder(
        builder: (BuildContext context, setState){
          return RefreshIndicator(
            onRefresh: () async {setState(() {});},
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: FutureBuilder<List>(
                future: driverController.getRequests(userManagement.loggedInDriver?.uid ?? ''),
                builder: (BuildContext context, snapshot){
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, i){

                        RequestModel request = driverController.createRequestFromJson(snapshot.data?[i]);
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
                            child: Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                                      child: LabelInputField(
                                        text: "Hvor skal du flytte fra?",
                                        controller: controller,
                                        maxLines: null,
                                      ),
                                    )
                                ),
                                Container(
                                    height: 110.h,
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
                        );
                      }
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
