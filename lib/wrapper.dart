import 'package:cphflyt/screens/home.dart';
import 'package:cphflyt/screens/login.dart';
import 'package:cphflyt/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cphflyt/models/user_model.dart';
import 'package:cphflyt/controllers/bottom_nav_controller.dart';
import 'package:cphflyt/controllers/user_management_controller.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return StreamBuilder(
      stream: authService.user,
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data as User?;

          if (user != null){
            authService.setUserType(user.uid, Provider.of<UserManagementController>(context, listen: false),  Provider.of<BottomNavController>(context, listen: false));
          }

          return user == null ? Login() : Home();
        }
        else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator()
            ),
          );
        }
      },
    );
  }
}
