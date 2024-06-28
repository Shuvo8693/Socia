import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:socia/features/profile/data/models/firestore_update_result.dart';
import 'package:socia/features/profile/data/models/update_user_model.dart';
import 'package:socia/home_screen_imports.dart';

class UpdateProfileService {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  String errorMessage = '';


  Future<UpdateResult> requestToUpdateProfile(
      {required UpdateUserModel params, XFile? imageFile}) async {
    // String uID =FirebaseAuth.instance.currentUser!.uid;
    String constUid = 'GCl5IWWmviWgHrBeekaHtd1gJ0h1';
    bool result = false;
    try {
      QuerySnapshot querySnapshot = await fireStore
          .collection('User')
          .where('userName', isEqualTo: params.userName)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        errorMessage = 'This userName already exist, please try another name';
      } else {
        await _imageUpdate(imageFile, constUid);
        result = await _userUpdate(params, constUid);
      }
      return UpdateResult(result: result);
    } catch (error) {
      errorMessage = error.toString();
      log(errorMessage);
      return UpdateResult(result: false);
    }
  }

  Future<void> _imageUpdate(XFile? imageFile, String uID) async {
    Uint8List? image = await imageFile?.readAsBytes();
    try {
      if (image != null) {
        final storageRef = await firebaseStorage
            .ref()
            .child('profile_images/$uID/${imageFile!.path.split('/').last}')
            .putData(image);
        final String imageUrl = await storageRef.ref.getDownloadURL();
        if (imageUrl.isNotEmpty) {
          await fireStore
              .collection('User')
              .doc(uID)
              .update({'profilePictureURL': imageUrl});
        }
      }
    } catch (error) {
      log(error.toString());
    }
  }

  Future<bool> _userUpdate(UpdateUserModel userParams, String uid) async {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    try {
      if (userParams.userName.isNotEmpty && userParams.displayName.isNotEmpty) {
        await fireStore
            .collection('User')
            .doc(uid)
            .update(userParams.toFireStore());
      }
      return true;
    } catch (error) {
      return false;
    }
  }
}
