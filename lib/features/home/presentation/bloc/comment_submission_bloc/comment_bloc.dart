
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia/features/home/data/service/comment_submission_service.dart';

import 'comment_event.dart';
import 'comment_state.dart';


class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentSubmissionService commentService;

  CommentBloc(this.commentService) : super(InitCommentState()) {
    on<LoadCommentEvent>(
        (event, emit) async => await onLoadCommentEvent(event, emit));
  }

  onLoadCommentEvent(event, emit) async {
    if (event is LoadCommentEvent) {
      emit(LoadingCommentState());
      await commentService
          .sendComment(postID: event.postID, content: event.content)
          .then((result) {
        if (result) {
          emit(LoadedCommentState());
        } else {
          emit(FailureCommentState(errorMessage: commentService.errorMessage));
        }
      });
    }
  }
}
