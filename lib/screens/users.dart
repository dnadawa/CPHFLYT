import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cphflyt/controllers/user_management_controller.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:cphflyt/widgets/drawer.dart';
import 'package:cphflyt/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Users extends StatelessWidget {
  final UserType type;

  const Users({required this.type});

  @override
  Widget build(BuildContext context) {
    var userController = Provider.of<UserManagementController>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          text: type == UserType.Driver ? "List of Drivers" : "List of Employees",
          fontSize: 22.sp,
          isBold: true,
          color: Colors.white,
        ),
      ),
      drawer: AppDrawer(type == UserType.Driver ? "List of Drivers" : "List of Employees"),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>(
          future:
              type == UserType.Driver ? userController.getDrivers() : userController.getEmployees(),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, i) => UserCard(
                name: snapshot.data![i]['name'],
                email: snapshot.data![i]['email'],
                phone: snapshot.data![i]['phone'],
                id: snapshot.data![i].id,
                type: type,
              ),
            );
          },
        ),
      ),
    );
  }
}
