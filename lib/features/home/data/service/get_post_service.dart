import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:socia/core/utility/service/firebase_resource.dart';
import 'package:socia/features/home/data/model/post.dart';

class GetPostService {
  List<PostList> postListModal = [];
  String errorMessage = '';

  Stream<Either<String, List<PostList>>> fetchPost() async* {
    String cUID = FirebaseResource.currentUID;
    FirebaseFirestore fireStore = FirebaseFirestore.instance;

    try {
      Stream<DocumentSnapshot<Map<String, dynamic>>> documentStream =
          fireStore.collection('User').doc(cUID).snapshots();

      await for (DocumentSnapshot<Map<String, dynamic>> document
          in documentStream) {
        if (document.exists) {
          List<dynamic>? followingList = document.data()?['Following'];

          if (followingList != null && followingList.isNotEmpty) {
            List<dynamic> limitFollowingList = followingList.take(10).toList();
            Stream<QuerySnapshot<Map<String, dynamic>>> documentQueryStream =
                fireStore
                    .collection('Post')
                    .where('userId', whereIn: limitFollowingList)
                    .orderBy('timestamp', descending: true)
                    .limit(10)
                    .snapshots();
            await for (QuerySnapshot<Map<String, dynamic>> postDoc
                in documentQueryStream) {
              if (postDoc.docs.isNotEmpty) {
                postListModal = postDoc.docs.map((doc){
                  final postData = doc.data();
                  return PostList.fromFireStore(postData);
                }).toList();
                yield Right(postListModal);
              } else {
                errorMessage = 'Post is empty';
                yield Left(errorMessage);
              }
            }
          } else {
            errorMessage = 'Timeline Empty: You have not followed someone yet';
            yield Left(errorMessage);
          }
        } else {
          errorMessage = 'User document does not exist';
          yield Left(errorMessage);
        }
      }
    } catch (error) {
      log(error.toString());
      errorMessage = 'Something went wrong: Unable to load data ';
      if (error is FormatException) {
        errorMessage = error.message;
      }
      yield Left(errorMessage);
    }
  }
}
