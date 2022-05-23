import 'package:cphflyt/constants.dart';
import 'package:cphflyt/controllers/user_management_controller.dart';
import 'package:cphflyt/screens/home.dart';
import 'package:cphflyt/screens/user_management.dart';
import 'package:cphflyt/screens/users.dart';
import 'package:cphflyt/services/auth_service.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:cphflyt/widgets/drawer_tile.dart';
import 'package:cphflyt/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  final String location;

  const AppDrawer(this.location);

  @override
  Widget build(BuildContext context) {
    var loggedInUserType =
        Provider.of<UserManagementController>(context).loggedInUserType;
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 2 * ScreenUtil().statusBarHeight,
          ),
          Padding(
            padding: EdgeInsets.all(25.w),
            child: Image.asset('assets/logo.png'),
          ),
          SizedBox(
            height: 30.h,
          ),

          ///home
          DrawerTile(
              location: location,
              iconData: Icons.home,
              name: "Home",
              destination: Home()),

          ///user management
          if (loggedInUserType == UserType.SuperAdmin)
            DrawerTile(
                location: location,
                iconData: Icons.group,
                name: "User Management",
                destination: UserManagement()),

          ///list of drivers
          if (loggedInUserType == UserType.SuperAdmin)
            DrawerTile(
                location: location,
                iconData: Icons.local_shipping,
                name: "List of Drivers",
                destination: Users(type: UserType.Driver)),

          ///list of drivers
          if (loggedInUserType == UserType.SuperAdmin)
            DrawerTile(
                location: location,
                iconData: Icons.person_pin,
                name: "List of Employees",
                destination: Users(type: UserType.Employee)),

          Expanded(child: SizedBox.shrink()),

          ///log out
          ListTile(
            leading: Icon(Icons.logout, color: kDeclined),
            title: CustomText(
              text: "Log out",
              isBold: true,
              color: Colors.black,
            ),
            onTap: () {
              Provider.of<AuthService>(context, listen: false).signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(builder: (context) => Wrapper()),
                  (Route<dynamic> route) => false);
            },
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}
