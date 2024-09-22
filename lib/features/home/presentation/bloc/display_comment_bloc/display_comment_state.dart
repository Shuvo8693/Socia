import 'package:socia/features/home/data/model/comment.dart';

abstract class DisplayCommentState {}

class InitDisplayCommentState extends DisplayCommentState {}

class LoadingDisplayCommentState extends DisplayCommentState {}

class LoadedDisplayCommentState extends DisplayCommentState {
  final List<Comment> commentList;

  LoadedDisplayCommentState(this.commentList);
}

class ErrorDisplayCommentState extends DisplayCommentState {
  final String errorMessage;

  ErrorDisplayCommentState(this.errorMessage);
}
