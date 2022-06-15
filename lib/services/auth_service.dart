import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cphflyt/controllers/bottom_nav_controller.dart';
import 'package:cphflyt/controllers/notification_controller.dart';
import 'package:cphflyt/controllers/user_management_controller.dart';
import 'package:cphflyt/models/driver_model.dart';
import 'package:cphflyt/models/employee_model.dart';
import 'package:cphflyt/models/user_model.dart';
import 'package:cphflyt/screens/driver_home.dart';
import 'package:cphflyt/screens/home.dart';
import 'package:cphflyt/services/database_service.dart';
import 'package:cphflyt/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

    final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

    User? _userFromFirebase(auth.User? user){
        if (user == null){
            return null;
        }

        return User(user.uid, user.email);
    }

    User? get currentUser {
        try{
            _auth.currentUser?.reload();
        }
        catch (e) {
            ToastBar(text: e.toString(), color: Colors.red).show();
            signOut();
        }

        _auth.currentUser?.reload();
        return _userFromFirebase(_auth.currentUser);
    }

    setUserType(String? uid,BuildContext context, UserManagementController userManagement, BottomNavController bottomNavController,bool isSignIn, {required bool isDriver}) async {
        if (isDriver){
            DocumentSnapshot userData = await DatabaseService().getDriverFromFirebase(uid!);
            
            if (userData.exists){
                userManagement.loggedInUserType = UserType.Driver;
                Driver driver = Driver(uid: uid, email: userData.get('email'), name: userData.get('name'), phone: userData.get('phone'));
                userManagement.loggedInDriver = driver;

                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('isDriver', true);

                NotificationController notificationController = NotificationController();
                String? id = await notificationController.getUserID();
                await DatabaseService().setNotificationID(id, uid);

                if(isSignIn){
                    Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) =>
                        DriverHome()), (Route<dynamic> route) => false);
                }

                // ToastBar(text: "Login Successful!", color: Colors.green).show();
            }
            else {
                signOut();
                ToastBar(text: "No Driver found for that email!", color: Colors.red).show();
            }
        }

        else {
            DocumentSnapshot userData = await DatabaseService().getUserDataFromFirebase(uid!);

            if (userData.exists && userData.get('role') == 'admin') {
                userManagement.loggedInUserType = UserType.Employee;
                Employee employee = Employee(uid: uid, email: userData.get('email'), name: userData.get('name'), page: userData.get('page') == 'website' ? Nav.Website : Nav.Manual, phone: userData.get('phone'));
                userManagement.loggedInEmployee = employee;
                bottomNavController.navItem = userData.get('page') == 'website' ? Nav.Website : Nav.Manual;

                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('isDriver', false);

                if(isSignIn){
                    Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) =>
                        Home()), (Route<dynamic> route) => false);
                }

                // ToastBar(text: "Login Successful!", color: Colors.green).show();
            }
            else if (userData.exists && userData.get('role') == 'main-admin'){
                userManagement.loggedInUserType = UserType.SuperAdmin;

                if(isSignIn) {
                    Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(builder: (context) =>
                            Home()), (Route<dynamic> route) => false);
                }
                // ToastBar(text: "Login Successful!", color: Colors.green).show();
            }
            else {
                signOut();
                ToastBar(text: "Access Denied!", color: Colors.red).show();
            }
        }

    }

    signIn(String email, String password,BuildContext context, UserManagementController userManagement, BottomNavController bottomNavController, {required bool isDriver}) async {
        try {
            final credential = await _auth.signInWithEmailAndPassword(
                email: email,
                password: password
            );

            String? uid = credential.user?.uid;
            setUserType(uid, context, userManagement, bottomNavController,true, isDriver: isDriver);

        } on auth.FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
                ToastBar(text: 'No user found for that email.', color: Colors.red).show();
            } else if (e.code == 'wrong-password') {
                ToastBar(text: 'Wrong password provided for that user.', color: Colors.red).show();
            }
        }
        catch (e){
            ToastBar(text: e.toString(), color: Colors.red).show();
        }
    }

    Future<User?>? signUp(String email, String password) async {
        try {
            FirebaseApp app = await Firebase.initializeApp(name: 'Secondary', options: Firebase.app().options);

            final credential = await auth.FirebaseAuth.instanceFor(app: app).createUserWithEmailAndPassword(
                email: email,
                password: password,
            );

            await app.delete();
            return _userFromFirebase(credential.user);

        } on auth.FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
                ToastBar(text: 'The password provided is too weak.', color: Colors.red).show();
            } else if (e.code == 'email-already-in-use') {
                ToastBar(text: 'The account already exists for that email.', color: Colors.red).show();
            }
        } catch (e) {
            ToastBar(text: e.toString(), color: Colors.red).show();
        }
        return null;
    }

    void signOut() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();

        try{
            await _auth.signOut();
        }
        catch(e){
            ToastBar(text: e.toString(), color: Colors.red).show();
        }
    }
}