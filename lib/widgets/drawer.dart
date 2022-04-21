import 'package:cphflyt/screens/home.dart';
import 'package:cphflyt/screens/user_management.dart';
import 'package:cphflyt/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {

  final String location;

  const AppDrawer(this.location);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Image.asset('assets/logo.png'),
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
        ],
      ),
    );
  }
}
