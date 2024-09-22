import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String content;
  final String displayName;
  final String profilePictureUrl;
  final int likesCount;
  final DateTime createdTime;
  final String userId;

  Comment({
    required this.content,
    required this.displayName,
    required this.profilePictureUrl,
    required this.likesCount,
    required this.createdTime,
    required this.userId,
  });

  factory Comment.fromFireStore(
      Map<String, dynamic> commentData, DocumentSnapshot userDoc) {
    return Comment(
      content: commentData['content'],
      displayName: userDoc['displayName'],
      profilePictureUrl: userDoc['profilePictureURL'],
      likesCount: commentData['likesCount'],
      createdTime: (commentData['createdAt'] as Timestamp).toDate(),
      userId: commentData['userId'],
    );
  }
}
