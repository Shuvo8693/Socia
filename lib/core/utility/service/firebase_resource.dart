import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseResource {
  static FirebaseFirestore get fireStore => FirebaseFirestore.instance;

  static FirebaseDatabase get dataBase => FirebaseDatabase.instance;

  static FirebaseStorage get storage => FirebaseStorage.instance;

  static FirebaseAuth get auth => FirebaseAuth.instance;

  static String get currentUID => auth.currentUser?.uid ?? '';
}
