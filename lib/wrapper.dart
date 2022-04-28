import 'package:cphflyt/screens/driver_home.dart';
import 'package:cphflyt/screens/home.dart';
import 'package:cphflyt/screens/login.dart';
import 'package:cphflyt/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cphflyt/controllers/bottom_nav_controller.dart';
import 'package:cphflyt/controllers/user_management_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatelessWidget {

  Future<bool> getDriverStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(preferences.getBool('isDriver'));
    return preferences.getBool('isDriver') ?? false;
  }

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return FutureBuilder<bool>(
      future: getDriverStatus(),
      builder: (context, snapshot){
        if(snapshot.hasData){

          if (authService.currentUser != null){
            authService.setUserType(
                authService.currentUser!.uid,
                context,
                Provider.of<UserManagementController>(context, listen: false),
                Provider.of<BottomNavController>(context, listen: false),
                isDriver: snapshot.data ?? false
            );

            return (snapshot.data ?? false) ? DriverHome() : Home();
          }
          else {
            return Login();
          }

        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
