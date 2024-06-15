import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:socia/features/profile/data/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  String existMessage = '';

  Future<bool> createCredentials(String email, String password, UserModel userModel) async {
    QuerySnapshot result = await _fireStore
        .collection('User')
        .where('email', isEqualTo: email)
        .get();

    final List<DocumentSnapshot> document = result.docs;

    if (document.isEmpty) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        return await _fireStore.collection('User').doc(value.user!.uid).set(
              userModel.toJson(),
            );
      }).onError((error, stackTrace) => print('createCredential: $error'));
      return true;
    } else {
      existMessage = 'This Email Already Exist ';
      log(existMessage);
      return false;
    }
  }
}
