import 'package:dartz/dartz.dart';
import 'package:socia/core/utility/service/firebase_resource.dart';

class CommentCounterService {
  String _errorMessage = '';

  Stream<Either<String, int>> fetchCommentCount(String postId) async* {
    try {
      final postSnap = FirebaseResource.fireStore.collection('Post').doc(postId).snapshots();
      yield* postSnap.map((docSnap) {
        int commentCount = 0;
        Map<String, dynamic>? docData = docSnap.data();
        if (docData != null) {
          commentCount = docData['commentCount'];
          return Right(commentCount);
        } else {
          _errorMessage = 'Post is not available';
          return Left(_errorMessage);
        }
      });
    } on Exception catch (e) {
      _errorMessage = e.toString();
      yield Left(_errorMessage);
    }
  }
}
