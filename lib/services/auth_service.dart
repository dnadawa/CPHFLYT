import 'package:cphflyt/models/user_model.dart';
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

    Future<User?>? signIn(String email, String password) async {
        try {
            final credential = await _auth.signInWithEmailAndPassword(
                email: email,
                password: password
            );

            return _userFromFirebase(credential.user);

        } on auth.FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
                ToastBar(text: 'No user found for that email.', color: Colors.red).show();
            } else if (e.code == 'wrong-password') {
                ToastBar(text: 'Wrong password provided for that user.', color: Colors.red).show();
            }
        }
        catch (e){
            ToastBar(text: 'Something went wrong!', color: Colors.red).show();
        }
    }

}