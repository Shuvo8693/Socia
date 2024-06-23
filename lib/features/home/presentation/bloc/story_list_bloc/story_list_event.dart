import 'package:equatable/equatable.dart';

abstract class StoryListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadStoryListEvent extends StoryListEvent {}

class FailureStoryListEvent extends StoryListEvent {}
