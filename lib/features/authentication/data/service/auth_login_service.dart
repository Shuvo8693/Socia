import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:socia/features/authentication/data/model/auth_result.dart';
import 'package:socia/features/authentication/widget/auth_exception.dart';

class AuthLogInService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String errorMessage = '';

  Future<AuthResult> requestToLogIn(String email, String password) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        return AuthResult(success: true, user: result.user);
      } else {
        return AuthResult(
            success: false,
            errorMessage:
                'Authentication failed, Please Input Correct Email & Password');
      }
    } on FirebaseAuthException catch (error) {
       authException(error,errorMessage);
       log(error.toString());
      return AuthResult(success: false, errorMessage: errorMessage);
    }
  }
}
