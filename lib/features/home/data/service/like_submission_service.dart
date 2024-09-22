import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:socia/core/utility/service/firebase_resource.dart';

class LikeSubmissionService {
  Future<Either<String, bool>> sendLike(String postID) async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    String cUID = FirebaseResource.currentUID;
    try {
      QuerySnapshot<Map<String, dynamic>> likeQuery = await FirebaseResource
          .fireStore
          .collection('Post')
          .doc(postID)
          .collection('likes')
          .get();

      bool isLiked = likeQuery.docs.isNotEmpty
          ? likeQuery.docs.any((element) => element.data()['userId'] == cUID)
          : false;

      if (!isLiked) {
        /// Add a like
        CollectionReference docRef =
            fireStore.collection('Post').doc(postID).collection('likes');
        await docRef.add({'userId': cUID});
        await fireStore.collection('Post').doc(postID).update({
          'likeCount': FieldValue.increment(1),
        });

        return const Right(true);
      } else {
        /// Remove a like
        CollectionReference docRef =
            fireStore.collection('Post').doc(postID).collection('likes');
        QuerySnapshot queryUserId =
            await docRef.where('userId', isEqualTo: cUID).get();
        if (queryUserId.docs.isNotEmpty) {
          for (var doc in queryUserId.docs) {
            await docRef.doc(doc.id).delete();
            await fireStore.collection('Post').doc(postID).update({
              'likeCount': FieldValue.increment(-1),
            });
          }
          return const Right(false);
        } else {
          return const Left('No like found for the user');
        }
      }
    } catch (error) {
      return Left('Failed to process Like/Unlike : $error');
    }
  }
}
