import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socia/core/utility/service/firebase_resource.dart';
import 'package:socia/features/profile/data/models/user_model.dart';

class StoryService {
  String image = '';
  String errorMessage = '';
  List<UserItem> userList = [];
  List<String> imageList = [];
  final String uID = FirebaseResource.currentUID;

  Future<bool> requestToGetStoryImageAndProfile() async {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;

    try {
      await fireStore
          .collection('Story')
          .where('userId', isEqualTo: uID)
          .get()
          .then((QuerySnapshot<Map<String, dynamic>> snapshot) async {
        if (snapshot.docs.isNotEmpty) {
          image = snapshot.docs.first.data()['imageUrl'];
        } else {
          errorMessage = 'Story Empty';
        }
      }).whenComplete(() async {
        await fireStore
            .collection('User')
            .doc(uID)
            .get()
            .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.exists && snapshot.data() != null) {
            var dataMap = snapshot.data();
            if (dataMap != null) {
              userList.add(UserItem.fromJson(dataMap));
            }
          } else {
            errorMessage = "Data doesn't exist";
            log(errorMessage);
          }
        });
      });
      return image.isNotEmpty || userList.isNotEmpty;
    } catch (error) {
      errorMessage = error.toString();
      log(errorMessage);
      return false;
    }
  }

  Future<bool> requestToGetStoryList() async {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    try {
      await fireStore.collection('User').doc(uID).get().then((value) async {
        List<dynamic> followingList = await value.get('Following');
        if (value.exists) {
          await fireStore
              .collection('Story')
              .where('userId', whereIn: followingList)
              .get()
              .then((value) {
            if (value.docs.isNotEmpty) {
              imageList = value.docs
                  .map((keyValue) {
                    return keyValue.data()['imageUrl'];
                  })
                  .cast<String>()
                  .toList();
            } else {
              errorMessage = 'Empty Story';
            }
          }).whenComplete(() async {
            for (var listID in followingList) {
              await fireStore
                  .collection('User')
                  .doc(listID)
                  .get()
                  .then((value) {
                final userData = value.data();
                if (value.exists && userData != null) {
                  userList.add(UserItem.fromJson(userData));
                } else {
                  errorMessage = 'Empty user data';
                }
              });
            }
          });
        } else {
          errorMessage = 'Empty user credential';
        }
      });
      return imageList.isNotEmpty || userList.isNotEmpty;
    } catch (error) {
      log(error.toString());
      return false;
    }
  }
}
