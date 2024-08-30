import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddStoryService {
  String errorMessage = '';
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<bool> requestToUploadImageStory(XFile image) async {
    String constUid = '0JSumE4bmSTZk45canRG3KRujmN2';
    // String uID = FirebaseAuth.instance.currentUser!.uid;
    Uint8List imageData = await image.readAsBytes();

    try {
      final storagePath = _firebaseStorage
          .ref()
          .child('story_images/$constUid/${image.path.split('/').last}');
      if (imageData.isNotEmpty) {
        TaskSnapshot task = await storagePath.putData(imageData);
        String url = await task.ref.getDownloadURL();

        QuerySnapshot valueData = await _fireStore
            .collection('Story')
            .where('userId', isEqualTo: constUid)
            .get();
        bool result = await uploadImage(url, constUid, valueData);
        if (result) {
          return true;
        } else {
          return false;
        }
      } else {
        errorMessage = 'Please input image';
        log(errorMessage);
        return false;
      }
    } catch (error) {
      log(error.toString());
      return false;
    }
  }

  Future<bool> uploadImage(
      String url, String uID, QuerySnapshot valueData) async {
    try {
      if (valueData.docs.isNotEmpty) {
        for (var doc in valueData.docs) {
          await _fireStore
              .collection('Story')
              .doc(doc.id)
              .update({'imageUrl': url});
        }
      } else {
        await _fireStore
            .collection('Story')
            .doc(uID)
            .set({'imageUrl': url, 'userId': uID});
      }
      return true;
    } on Exception catch (error) {
      errorMessage = 'An error occurred : $error';
      return false;
    }
  }
}
