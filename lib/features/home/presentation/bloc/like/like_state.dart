
 class LikeState {
   final bool isLiked;
   final int likeCount;
   final String? errorMessage;

  LikeState(this.isLiked, this.likeCount, {this.errorMessage});
 }

/*class InitLikeState extends LikeState {}

class LoadedLikeState extends LikeState {
  final String successMessage;

  LoadedLikeState(this.successMessage);
}

class FailureLikeState extends LikeState {
  final String errorMessage;

  FailureLikeState(this.errorMessage);
}

class UpdatePostLikeState extends LikeState {
  final LikeModal likeModal;

  UpdatePostLikeState(this.likeModal);
}*/
