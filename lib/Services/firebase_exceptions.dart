
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseExceptions implements Exception{

  FirebaseExceptions(FirebaseException exception){
    switch (exception.code){
      case 'weak-password':
        throw "Password is week.Please enter more than five characters.";
      case 'email-already-in-use':
        throw "Email already exist.Please try with different email.";
      case 'invalid-email':
        throw "Invalid email address.";
      case 'user-disabled':
        throw "Your account is disabled.";
      case 'user-not-found':
        throw "This account doesn't exist";
      case 'requires-recent-login':
        throw "Please logout and login again to perform this action.";
      case 'wrong-password':
        throw "Incorrect Password.";
      case 'expired-action-code':
        throw "Session is expired. Please try again.";
      case 'operation-not-allowed':
        throw "This operation is disabled from our end. Try after a while";
      case 'account-exists-with-different-credential':
        throw "This account already exist.";
      case 'user-token-expired':
        throw "User token expired. Please try again.";
      case 'invalid-action-code':
        throw "Code is invalid. Please enter valid code";
      case 'network-request-failed':
        throw "Internet not connected.";
      case 'too-many-requests':
        throw "Due to too many requests, you are blocked temporary.";
      default:
        throw exception.message.toString();
    }
  }
  
}