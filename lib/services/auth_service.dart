import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cphflyt/controllers/bottom_nav_controller.dart';
import 'package:cphflyt/controllers/user_management_controller.dart';
import 'package:cphflyt/models/employee_model.dart';
import 'package:cphflyt/models/user_model.dart';
import 'package:cphflyt/services/database_service.dart';
import 'package:cphflyt/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

class AuthService {

    final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

    User? _userFromFirebase(auth.User? user){
        if (user == null){
            return null;
        }

        return User(user.uid, user.email);
    }

    Stream<User?>? get user {
        return _auth.authStateChanges().map(_userFromFirebase);
    }

    setUserType(String? uid, UserManagementController userManagement, BottomNavController bottomNavController) async {
        DocumentSnapshot userData = await DatabaseService().getUserDataFromFirebase(uid!);

        if (userData.exists && userData.get('role') == 'admin') {
            userManagement.loggedInUserType = UserType.Employee;
            Employee employee = Employee(uid: uid, email: userData.get('email'), name: userData.get('name'), page: userData.get('page') == 'website' ? Nav.Website : Nav.Manual);
            userManagement.loggedInEmployee = employee;
            bottomNavController.navItem = userData.get('page') == 'website' ? Nav.Website : Nav.Manual;
            ToastBar(text: "Login Successful!", color: Colors.green).show();
        }
        else if (userData.exists && userData.get('role') == 'main-admin'){
            userManagement.loggedInUserType = UserType.SuperAdmin;
            ToastBar(text: "Login Successful!", color: Colors.green).show();
        }
        else {
            signOut();
            ToastBar(text: "Access Denied!", color: Colors.red).show();
        }
    }

    signIn(String email, String password, UserManagementController userManagement, BottomNavController bottomNavController) async {
        try {
            final credential = await _auth.signInWithEmailAndPassword(
                email: email,
                password: password
            );

            String? uid = credential.user?.uid;
            setUserType(uid, userManagement, bottomNavController);

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
            final credential = await _auth.createUserWithEmailAndPassword(
                email: email,
                password: password,
            );

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
    }

    void signOut() async {
        try{
            await _auth.signOut();
        }
        catch(e){
            ToastBar(text: e.toString(), color: Colors.red).show();
        }
    }
}