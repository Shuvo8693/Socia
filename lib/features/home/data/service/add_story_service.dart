import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddStoryService {
  String errorMessage = '';
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<bool> requestToUploadImageStory(XFile image) async {
    String constUid = 'GCl5IWWmviWgHrBeekaHtd1gJ0h1';
   // String uID = FirebaseAuth.instance.currentUser!.uid;
    Uint8List imageData = await image.readAsBytes();

    try {
      final storagePath = _firebaseStorage
          .ref()
          .child('story_images/$constUid/${image.path.split('/').last}');
      if (imageData.isNotEmpty) {
        await storagePath.putData(imageData).then((TaskSnapshot task) async {
          String url = await task.ref.getDownloadURL();

          QuerySnapshot valueData = await _fireStore
              .collection('Story')
              .where('userId', isEqualTo: constUid)
              .get();

          if (valueData.docs.isNotEmpty){
            for (var doc in valueData.docs){
              await _fireStore
                  .collection('Story')
                  .doc(doc.id)
                  .update({'imageUrl': url});
            }
          } else {
            await _fireStore
                .collection('Story')
                .doc(constUid)
                .set({'imageUrl': url, 'userId': constUid});
          }
        });
        return true;
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
}
