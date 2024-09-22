import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:socia/core/utility/service/firebase_resource.dart';

class ProfileImageService {
  String errorMessage = '';

  Future<Either<String, String>> fetchProfileImage() async {
    final String uID = FirebaseResource.currentUID;
    FirebaseFirestore fireStore=FirebaseFirestore.instance;

    DocumentSnapshot<Map<String, dynamic>> profileData =
        await fireStore.collection('User').doc(uID).get();
    if (profileData.exists) {
      String? profilePicture = profileData['profilePictureURL'];
      if (profilePicture != null) {
        return Right(profilePicture);
      } else {
        return Left(errorMessage);
      }
    } else {
      return Left(errorMessage);
    }
  }
}
