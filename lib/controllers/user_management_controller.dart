import 'package:cphflyt/models/driver_model.dart';
import 'package:cphflyt/models/employee_model.dart';
import 'package:cphflyt/models/user_model.dart';
import 'package:cphflyt/services/auth_service.dart';
import 'package:cphflyt/services/database_service.dart';
import 'package:flutter/foundation.dart';

import 'bottom_nav_controller.dart';

enum UserType {Driver, Employee}

class UserManagementController extends ChangeNotifier {

  UserType _selected = UserType.Driver;

  UserType get userType{
    return _selected;
}

  set userType(UserType type){
    _selected = type;
    notifyListeners();
  }


  Future<bool> registerUser({required String name, required String email, required String password, required UserType type, Nav? accessedPage}) async {
    User? registeredUser = await AuthService().signUp(email, password);
    if (registeredUser!=null && type == UserType.Driver){
      Driver driver = Driver(uid: registeredUser.uid, email: registeredUser.email, name: name);
      return await DatabaseService().addDriver(driver);
    }
    else if (registeredUser!=null && type == UserType.Employee){
      Employee employee = Employee(uid: registeredUser.uid, email: registeredUser.email, name: name, page: accessedPage!);
      return await DatabaseService().addEmployee(employee);
    }

    return false;
  }

}