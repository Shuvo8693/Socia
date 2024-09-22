abstract class CommentEvent {}

class LoadCommentEvent extends CommentEvent {
  final String postID;
  final String content;

  LoadCommentEvent({required this.postID, required this.content});
}
