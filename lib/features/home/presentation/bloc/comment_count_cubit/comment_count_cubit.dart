import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia/features/home/data/service/commentcounter_service.dart';
import 'package:socia/features/home/presentation/bloc/comment_count_cubit/comment_counter_state.dart';

class CommentCountCubit extends Cubit<CommentCounterState> {
  CommentCounterService commentCounterService;
  StreamSubscription<Either<String, int>>? _streamSubscription;

  CommentCountCubit(this.commentCounterService) : super(CommentCounterState(0));

  Future<void> mapToCommentCounter(String postId) async {
    await _streamSubscription?.cancel();
    _streamSubscription =
        commentCounterService.fetchCommentCount(postId).listen((result) {
      result.fold(
        (failure) {
          log(failure);
          emit(CommentCounterState(state.commentCount,errorMessage: failure));
        },
        (commentCount) {
          emit(CommentCounterState(commentCount));
        },
      );
    });
  }
  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
