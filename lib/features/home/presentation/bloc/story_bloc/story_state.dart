import 'package:equatable/equatable.dart';

import '../../../../profile/data/models/user_model.dart';

abstract class StoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitializeStoryState extends StoryState {}

class LoadingStoryState extends StoryState {}

class ImageProfileLoadStoryState extends StoryState {
  final String image;
  final List<UserList> userList;

  ImageProfileLoadStoryState({required this.image, required this.userList});
}

class FailureStoryState extends StoryState {
  final String errorMessage;

  FailureStoryState({required this.errorMessage});
}
