import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:socia/features/home/data/service/like_post_get_service.dart';
import 'package:socia/features/home/data/service/like_submission_service.dart';
import 'package:socia/features/home/presentation/bloc/like/like_state.dart';
import 'package:socia/home_screen_imports.dart';

class LikeCubit extends Cubit<LikeState> {
  final LikeSubmissionService likeService;
  final LikePostGetService likePostGetService;

  StreamSubscription<Either<String, LikeModal>>? _likeSubscription;

  LikeCubit(this.likeService, this.likePostGetService)
      : super(LikeState(false, 0));

  Future<void> toggleLike(BuildContext context, String postId) async {
    await likeService.sendLike(postId).then((result) {
      result.fold((failure) {
        emit(LikeState(state.isLiked, state.likeCount, errorMessage: failure));
      }, (isLiked) {
        snackBarMessage(
            context: context, title: isLiked ? 'Like added' : 'Liked removed');
      });
    });
  }

  Future<void> updateLikePost(BuildContext context, String postId) async {
    await _likeSubscription?.cancel();
    _likeSubscription =
        likePostGetService.fetchPostLike(postId).listen((result) {
      result.fold((failure) {
        emit(LikeState(state.isLiked, state.likeCount, errorMessage: failure));
      }, (likeModal) {
        emit(LikeState(likeModal.isLiked, likeModal.likeCount));
      });
    });
  }

  @override
  Future<void> close() {
    _likeSubscription?.cancel();
    return super.close();
  }
}
