import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socia/features/home/data/model/post_modal.dart';

class GetPostService {
  List<PostList> postListModal = [];
  String errorMessage = '';

  Future<bool> fetchPost() async {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    // String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    try {
      DocumentSnapshot document = await fireStore
          .collection('User')
          .doc('0JSumE4bmSTZk45canRG3KRujmN2')
          .get();
      List<dynamic> followingList = document['Following'];
      if (followingList.isNotEmpty) {
        await fireStore
            .collection('Post')
            .where('userId', whereIn: followingList)
            .orderBy('timestamp', descending: true)
            .limit(15)
            .get()
            .then((postDoc) {
          if (postDoc.docs.isNotEmpty) {
            postListModal =
                postDoc.docs.map((doc) => PostList.fromFireStore(doc)).toList();
          } else {
            errorMessage = 'Post is empty';
          }
        });
      } else {
        errorMessage = 'Timeline Empty: You have not followed someone yet';
      }
      return postListModal.isNotEmpty;
    } catch (error) {
      errorMessage = 'Something went wrong: Unable to load data ';
      if(error is FormatException){
        errorMessage= error.message;
      }
      log(errorMessage);
      return false;
    }
  }
}
