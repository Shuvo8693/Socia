import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:socia/features/authentication/data/model/auth_result.dart';
import 'package:socia/features/authentication/widget/auth_exception.dart';
import 'package:socia/features/profile/data/models/user_model.dart';

class AuthRegisterService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  String errorMessage = '';

  Future<AuthResult> createCredentials(
      String email, String password, UserItem userModel) async {
    QuerySnapshot result = await _fireStore
        .collection('User')
        .where('email', isEqualTo: email)
        .get();

    final List<QueryDocumentSnapshot> document = result.docs;

    return createUser(document, email, password, userModel);
  }

  Future<AuthResult> createUser(List<QueryDocumentSnapshot> document,
      String email, String password, UserItem userModel) async {
    try {
      if (document.isEmpty) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        try {
          await _fireStore
              .collection('User')
              .doc(credential.user!.uid)
              .set(userModel.toJson());
        } catch (error) {
          return AuthResult(
              success: false, errorMessage: 'Failed to save your information');
        }

        return AuthResult(
            success: credential.user != null, user: credential.user);
      } else {
        return AuthResult(
            success: false, errorMessage: 'This mail is already exist');
      }
    } catch (error) {
      if (error is FirebaseAuthException) {
        authException(error, errorMessage);
      }
      return AuthResult(
          success: false, errorMessage: 'Something went wrong try again');
    }
  }
}
