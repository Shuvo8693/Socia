import 'dart:developer';
import 'dart:typed_data';

import 'package:socia/core/utility/service/firebase_resource.dart';
import 'package:socia/features/profile/data/models/firestore_update_result.dart';
import 'package:socia/features/profile/data/models/update_user_model.dart';
import 'package:socia/home_screen_imports.dart';

class UpdateProfileService {
  String errorMessage = '';

  Future<UpdateResult> requestToUpdateProfile(
      {required UpdateUserModel params, XFile? imageFile}) async {
    String uID = FirebaseResource.currentUID;
    bool userResult = false;
    bool imageResult = false;

    try {
      QuerySnapshot querySnapshot = await FirebaseResource.fireStore
          .collection('User')
          .where('userName',
              isEqualTo:
                  params.userName == '' ? 'Empty-Input56' : params.userName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        errorMessage = 'This userName already exist, please try another name';
      } else {
        if (imageFile!.path.isNotEmpty) {
          imageResult = await _imageUpdate(imageFile, uID);
        }
        if (params.bio.isNotEmpty ||
            params.displayName.isNotEmpty ||
            params.userName.isNotEmpty) {
          userResult = await _userUpdate(params, uID);
        }
      }

      return UpdateResult(result: userResult || imageResult);
    } catch (error) {
      log(errorMessage);
      return UpdateResult(result: false);
    }
  }

  Future<bool> _imageUpdate(XFile? imageFile, String uID) async {
    Uint8List? image = await imageFile?.readAsBytes();
    try {
      if (image != null) {
        final storageRef = await FirebaseResource.storage
            .ref()
            .child('profile_images/$uID/${imageFile!.path.split('/').last}')
            .putData(image);
        final String imageUrl = await storageRef.ref.getDownloadURL();
        if (imageUrl.isNotEmpty) {
          await FirebaseResource.fireStore
              .collection('User')
              .doc(uID)
              .update({'profilePictureURL': imageUrl});
          return true;
        }
      }
      errorMessage = image == null ? 'Empty image input' : '';
      return false;
    } catch (error) {
      log(error.toString());
      return true;
    }
  }

  Future<bool> _userUpdate(UpdateUserModel userParams, String uid) async {
    try {
      if (userParams.userName.isNotEmpty ||
          userParams.displayName.isNotEmpty ||
          userParams.bio.isNotEmpty) {
        await FirebaseResource.fireStore
            .collection('User')
            .doc(uid)
            .update(userParams.toFireStore());
      } else if (userParams.userName.isEmpty &&
          userParams.displayName.isEmpty) {
        errorMessage = 'Naming input are empty';
        return false;
      }
      return true;
    } catch (error) {
      return false;
    }
  }
}
