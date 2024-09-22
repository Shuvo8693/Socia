import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';
import 'package:socia/core/utility/service/firebase_resource.dart';

class LikePostGetService {
  bool _isLiked = false;
  int _likeCount = 0;
  String errorMessage = '';

  Stream<Either<String, LikeModal>> fetchPostLike(String postId) async* {
    try {
      final likeSnapshot = FirebaseResource.fireStore
          .collection('Post')
          .doc(postId)
          .collection('likes')
          .snapshots();
      final postSnapshot =
          FirebaseResource.fireStore.collection('Post').doc(postId).snapshots();

      yield* CombineLatestStream.combine2(
        likeSnapshot,
        postSnapshot,
        (QuerySnapshot<Map<String, dynamic>> likeDoc,
            DocumentSnapshot<Map<String, dynamic>> postDoc) {
          if (likeDoc.docs.isNotEmpty) {
            _isLiked = likeDoc.docs.any((element) =>
                element.data()['userId'] == FirebaseResource.currentUID);
          } else {
            _isLiked = false;
          }

          if (postDoc.exists) {
            _likeCount = postDoc.data()?['likeCount'] ?? 0;
          } else {
            errorMessage = 'Post is not found';
          }
          return Right(LikeModal(_isLiked, _likeCount));
        },
      );
    } on Exception catch (error) {
      errorMessage = error.toString();
      yield Left(errorMessage);
    }
  }
}

class LikeModal {
  final bool isLiked;
  final int likeCount;

  LikeModal(this.isLiked, this.likeCount);
}
