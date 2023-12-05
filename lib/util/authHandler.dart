import 'package:firebase_auth/firebase_auth.dart';


class AuthExceptionHandler {
  static String handleAuthException(FirebaseAuthException e) {
    String status;
    switch (e.code) {
      case "invalid-email":
        status = "Your email address appears to be malformed.";
        break;
      case "wrong-password":
        status = "Your email or password is wrong.";
        break;
      case "weak-password":
        status = "Your password should be at least 6 characters.";
        break;
      case "email-already-in-use":
        status = "The email address is already in use by another account.";
        break;
      default:
        status ="An error occured. Please try again later.";
    }
    return status;
  }
}