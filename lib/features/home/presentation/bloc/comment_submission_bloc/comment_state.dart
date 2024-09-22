abstract class CommentState {}

class InitCommentState extends CommentState {}

class LoadingCommentState extends CommentState {}

class LoadedCommentState extends CommentState {}

class FailureCommentState extends CommentState {
  final String errorMessage;

  FailureCommentState({required this.errorMessage});
}
