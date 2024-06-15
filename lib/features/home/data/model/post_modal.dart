

import 'package:cloud_firestore/cloud_firestore.dart';

class PostList {
  String caption;
  int commentCount;
  String displayName;
  String imageUrl;
  int likeCount;
  String profilePictureURL;
  Timestamp timestamp;
  String userId;
  String userName;

  PostList({
    required this.userName,
    required this.profilePictureURL,
    required this.displayName,
    required this.imageUrl,
    required this.caption,
    required this.commentCount,
    required this.likeCount,
    required this.userId,
    required this.timestamp,
  });

  factory PostList.fromFireStore(DocumentSnapshot doc) {
     Map data= doc.data() as Map;
    return PostList(
        userName: data['userName'],
        profilePictureURL: data['profilePictureURL'],
        displayName: data['displayName'],
        imageUrl: data['imageUrl'],
        caption: data['caption'],
        commentCount: data['commentCount'],
        likeCount: data['likeCount'],
        userId: data['userId'],
        timestamp: data['timestamp']);
  }

  Map<String, dynamic> toFireStore() {
    return {
      'userName': userName,
      'profilePictureURL': profilePictureURL,
      'displayName': displayName,
      'imageUrl': imageUrl,
      'caption': caption,
      'commentCount': commentCount,
      'likeCount': likeCount,
      'userId': userId,
      'timestamp': timestamp
    };
  }
}
