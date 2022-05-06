import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cphflyt/controllers/bottom_nav_controller.dart';
import 'package:cphflyt/controllers/driver_assign_controller.dart';
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
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:cphflyt/constants.dart';

class Home extends StatelessWidget {

  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var databaseService = Provider.of<DatabaseService>(context);
    var navController = Provider.of<BottomNavController>(context);
    var filterController = Provider.of<FilterController>(context);
    var userManagement = Provider.of<UserManagementController>(context);
    var requestController = Provider.of<DriverAssignController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: "Home", fontSize: 22.sp, isBold: true,color: Colors.white,),
      ),
      drawer: AppDrawer("home"),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            ToggleSwitch(
                initialLabelIndex: filterController.filter==Filter.Pending?0:
                                   filterController.filter==Filter.Approved?1:2,
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
                onToggle: (index) async {
                  if (index==0){
                    filterController.filter = Filter.Pending;
                  }
                  else if (index==1){
                    filterController.filter = Filter.Approved;
                  }
                  else {
                    filterController.filter = Filter.Trash;
                  }
                },
              ),
            SizedBox(height: 20.h,),

            ///search box
            Row(
              children: [
                Expanded(
                  child: Material(
                    elevation: 7,
                    child: TextField(
                      controller: search,
                      decoration: InputDecoration(
                        hintText: "Enter email to search",
                        hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        suffixIconConstraints: BoxConstraints(
                          maxHeight: 35,
                          maxWidth: 35
                        ),
                        suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: (){
                            FocusScope.of(context).unfocus();
                            search.clear();
                          },
                          icon: Icon(Icons.clear),
                        )
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => databaseService.searchText = search.text,
                  child: Container(
                    padding: EdgeInsets.all(13.w),
                    margin: EdgeInsets.only(left: 10.w),
                    color: Theme.of(context).primaryColor,
                    child: Icon(Icons.search, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h,),

            ///add task
            if(navController.navItem == Nav.Manual)
            ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => Details(isAdd: true,)),
                    );
                  },
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
            if(navController.navItem == Nav.Manual)
            SizedBox(height: 30.h,),

            ///empty trash
            if(filterController.filter == Filter.Trash)
            Button(
                color: kDeclined,
                text: "Empty Trash",
                onPressed: ()=>requestController.emptyTrash(navController.navItem, context)
            ),
            if(filterController.filter == Filter.Trash)
            SizedBox(height: 30.h,),

            ///hide completed & date filter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///date picker
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2021, 1, 1),
                        lastDate: DateTime(2023, 12, 31),
                        cancelText: 'Clear'
                      );
                      await initializeDateFormatting('da_DK');
                      filterController.dateFilter = pickedDate;
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      height: 40.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2
                          )
                      ),
                      child: Center(
                          child: filterController.dateFilter == null ?
                          Icon(Icons.calendar_today, color: kLightBlue) :
                          CustomText(text: filterController.dateFilter == null ? "" : DateFormat.yMMMMd('da_DK').format(filterController.dateFilter!))
                      ),
                    ),
                  ),
                ),

                if(filterController.filter == Filter.Approved)
                ///dropdown
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2
                      )
                    ),
                    child: DropdownButton(
                        underline: SizedBox.shrink(),
                        value: filterController.completedFilter,
                        items: [
                          DropdownMenuItem(child: CustomText(text: 'All'), value: CompletedFilter.All,),
                          DropdownMenuItem(child: CustomText(text: 'Not Completed'), value: CompletedFilter.NotCompleted,),
                          DropdownMenuItem(child: CustomText(text: 'Completed'), value: CompletedFilter.Completed,),
                        ],
                        onChanged: (CompletedFilter? val){
                          filterController.completedFilter = val ?? CompletedFilter.All;
                        }
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h,),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: databaseService.getRequests(
                    filter: filterController.filter,
                    from: navController.navItem,
                    completedFilter: filterController.completedFilter,
                    dateFilter: filterController.dateFilter
                ),
                builder: (BuildContext context, snapshot){
                  if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, i){

                        RequestModel request = databaseService.createRequestFromJson(snapshot.data?.docs[i]);
                        final TextEditingController controller = TextEditingController();
                        controller.text = request.id;

                        return GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => Details(request: request, isCompleted: request.isCompleted,)),
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
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        if (filterController.filter == Filter.Approved)
                                        FutureBuilder<DocumentSnapshot<Map>>(
                                          future: databaseService.getDriverFromFirebase(request.driver!),
                                          builder: (context, snapshot){
                                            return Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),),
                                                color: kLightBlue,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 20.w),
                                                child: CustomText(
                                                  text: "Assigned Driver : ${snapshot.hasData ? snapshot.data!.data()!['name'].toString().split(' ')[0] : 'Loading...'}",
                                                  color: Colors.white,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                                          child: LabelInputField(
                                            text: "ID",
                                            controller: controller,
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.horizontal(right: Radius.circular(15.r)),
                                      color: kLightBlue,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: filterController.filter == Filter.Approved?47.h:35.h),
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
          ],
        ),
      ),

      bottomNavigationBar: userManagement.loggedInUserType == UserType.SuperAdmin ? BottomNavBar() : null,
    );
  }
}
