import 'package:firebase_auth/firebase_auth.dart';

authException(FirebaseAuthException error, String errorMessage) {
  switch (error.code) {
    case 'user-not-found':
      errorMessage = 'No user found to the given email';
      break;
    case 'invalid-credential':
      errorMessage =
          'Authentication failed, Please Input Correct Email & password ';
      break;
    case 'wrong-password':
      errorMessage = 'incorrect password';
      break;
    case 'invalid-email':
      errorMessage = 'The email address is not valid';
      break;
    case "email-already-in-use":errorMessage = "The email address is already in use ";
      break;
    default:
      errorMessage = 'An unknown error occurred. Please try again.';
  }
}
