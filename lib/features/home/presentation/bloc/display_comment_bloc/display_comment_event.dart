abstract class DisplayCommentEvent {}

class ListenToDisplayCommentEvent extends DisplayCommentEvent {
  final String postID;

  ListenToDisplayCommentEvent(this.postID);
}
