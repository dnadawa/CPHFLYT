import 'package:cphflyt/constants.dart';
import 'package:cphflyt/controllers/user_management_controller.dart';
import 'package:cphflyt/screens/home.dart';
import 'package:cphflyt/screens/user_management.dart';
import 'package:cphflyt/services/auth_service.dart';
import 'package:cphflyt/widgets/custom_text.dart';
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
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 2 * ScreenUtil().statusBarHeight,),
          Image.asset('assets/logo.png'),
          SizedBox(height: 30.h,),
          ListTile(
            leading: Icon(Icons.home, color: location=='home'?Theme.of(context).primaryColor:null),
            title: CustomText(text: "Home", isBold: true, color: location=='home'?Theme.of(context).primaryColor:Colors.black,),
            onTap: (){
              if (location=='home'){
                Navigator.pop(context);
              }
              else{
                Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) =>
                    Home()), (Route<dynamic> route) => false);
              }
            },
          ),
          if (Provider.of<UserManagementController>(context).loggedInUserType == UserType.SuperAdmin)
            ListTile(
            leading: Icon(Icons.person, color: location=='user-management'?Theme.of(context).primaryColor:null,),
            title: CustomText(text: "User Management", isBold: true, color: location=='user-management'?Theme.of(context).primaryColor:Colors.black,),
            onTap: (){
              if (location=='user-management'){
                Navigator.pop(context);
              }
              else{
                Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) =>
                    UserManagement()), (Route<dynamic> route) => false);
              }
            },
          ),
          Expanded(child: SizedBox.shrink()),
          ListTile(
            leading: Icon(Icons.logout, color: kDeclined),
            title: CustomText(text: "Log out", isBold: true, color: Colors.black,),
            onTap: (){
                Provider.of<AuthService>(context, listen: false).signOut();
                Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) =>
                    Wrapper()), (Route<dynamic> route) => false);
              },
          ),
          SizedBox(height: 30.h,),
        ],
      ),
    );
  }
}
