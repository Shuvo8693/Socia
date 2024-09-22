import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socia/core/utility/service/firebase_resource.dart';

class CommentSubmissionService {
  String errorMessage = '';

  Future<bool> sendComment(
      {required String postID, required String content}) async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    String cUID = FirebaseResource.currentUID;
    try {
      CollectionReference comment = fireStore
          .collection('Post')
          .doc(postID)
          .collection('comments');
      DocumentReference userRef = fireStore.collection('User').doc(cUID);

      final time = DateTime.now();
      DocumentReference docRef = await comment.add({
        'content': content,
        'likesCount': 0,
        'createdAt': time,
        'userId': cUID,
        'userRef': userRef
      }).whenComplete(() async {
        await fireStore
            .collection('Post')
            .doc(postID)
            .update({'commentCount': FieldValue.increment(1)});
      });
      return docRef.id.isNotEmpty;
    } catch (error) {
      errorMessage = 'Failed to comment on this post';
      log(error.toString());
      return false;
    }
  }
}
