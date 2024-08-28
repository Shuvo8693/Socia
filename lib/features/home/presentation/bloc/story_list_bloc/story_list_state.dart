import 'package:equatable/equatable.dart';

import '../../../../profile/data/models/user_model.dart';

abstract class StoryListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitializeListStoryState extends StoryListState {}

class LoadingListStoryState extends StoryListState {}

class LoadStoryListState extends StoryListState {
  final List<UserItem> userList;
  final List<String> imageListing;

  LoadStoryListState({required this.imageListing, required this.userList});
}

class FailureStoryListState extends StoryListState {
  final String errorMessage;

  FailureStoryListState({required this.errorMessage});
}
