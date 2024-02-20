import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_exceptions.dart';


class AuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

   static Future<bool> login(String? email, String? password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      return true;
    } on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      throw e.toString();
    }
  }

  static Future<bool> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = userCredential.user!;
      print('Signed in user: ${user.uid}');
      return true;
    }
    on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      print(e.toString());
      throw e.toString();
    }
  }


  static logout() async {
    await _auth.signOut();
  }


}