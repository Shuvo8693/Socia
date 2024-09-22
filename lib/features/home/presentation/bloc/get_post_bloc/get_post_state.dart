import 'package:equatable/equatable.dart';
import 'package:socia/features/home/data/model/post.dart';

abstract class GetPostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitializedGetPostState extends GetPostState {}

class LoadingGetPostState extends GetPostState {}

class LoadedGetPostState extends GetPostState {
  final List<PostList> postListModal;

  LoadedGetPostState({required this.postListModal});
}

class FailureGetPostState extends GetPostState {
  final String failureMessage;

  FailureGetPostState(this.failureMessage);
}
