import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cphflyt/models/driver_model.dart';
import 'package:cphflyt/models/employee_model.dart';
import 'package:cphflyt/models/user_model.dart';
import 'package:cphflyt/services/auth_service.dart';
import 'package:cphflyt/services/database_service.dart';
import 'package:cphflyt/widgets/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:cphflyt/controllers/bottom_nav_controller.dart';
import 'package:flutter/material.dart';

enum UserType {Driver, Employee, SuperAdmin}

class UserManagementController extends ChangeNotifier {

  UserType _selected = UserType.Driver;
  UserType? _loggedInUserType;
  Employee? _loggedInEmployee;
  Driver? _loggedInDriver;
  UserType _loginSelector = UserType.SuperAdmin;

  UserType get userType{
    return _selected;
}

  set userType(UserType type){
    _selected = type;
    notifyListeners();
  }

  UserType? get loggedInUserType {
    return _loggedInUserType;
  }

  set loggedInUserType(UserType? loggedInUser){
    _loggedInUserType = loggedInUser;
    notifyListeners();
  }

  Employee? get loggedInEmployee {
    return _loggedInEmployee;
  }

  set loggedInEmployee(Employee? employee){
    _loggedInEmployee = employee;
    notifyListeners();
  }

  Driver? get loggedInDriver {
    return _loggedInDriver;
  }

  set loggedInDriver(Driver? driver){
    _loggedInDriver = driver;
    notifyListeners();
  }

  UserType get loginSelector {
    return _loginSelector;
  }

  set loginSelector(UserType userType){
    _loginSelector = userType;
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

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> getDrivers() async {
    try{
      return await DatabaseService().getDrivers();
    }
    catch(e){
      ToastBar(text: e.toString(), color: Colors.red).show();
      return null;
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> getEmployees() async {
    try{
      return await DatabaseService().getEmployees();
    }
    catch(e){
      ToastBar(text: e.toString(), color: Colors.red).show();
      return null;
    }
  }
}