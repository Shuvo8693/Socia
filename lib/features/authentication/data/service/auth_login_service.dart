import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthLogInService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String errorMessage = '';

  Future<bool> requestToLogIn(String email, String password) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return result.user != null;
    } catch (error) {
      log(error.toString());
      errorMessage = 'Please Input Correct Email & Password';
      return false;
    }
  }
}
