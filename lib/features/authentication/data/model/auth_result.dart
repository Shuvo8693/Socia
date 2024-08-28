import 'package:firebase_auth/firebase_auth.dart';

class AuthResult{
  final bool success;
  final String? errorMessage;
  final User? user;

  AuthResult( {required this.success, this.user,this.errorMessage, });
}