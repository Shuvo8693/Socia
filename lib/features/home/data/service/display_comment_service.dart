import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:socia/features/home/data/model/comment.dart';

class DisplayCommentService {
  String errorMessage = '';

  Stream<Either<String, List<Comment>>> fetchComment(String postID) async* {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> commentSnap = fireStore
          .collection('Post')
          .doc(postID)
          .collection('comments')
          .snapshots();

      await for (QuerySnapshot<Map<String, dynamic>> commentDoc
          in commentSnap) {
        List<Comment> commentList =
            await Future.wait(commentDoc.docs.map((comment) async {
          Map<String, dynamic> commentData = comment.data();
          DocumentReference userRef = commentData['userRef'];
          DocumentSnapshot userDoc = await userRef.get();
          return Comment.fromFireStore(commentData, userDoc);
        }).toList());
        yield Right(commentList);
      }
    } catch (error) {
      errorMessage = 'Failed to load comment';
      yield Left(errorMessage);
    }
  }
}
