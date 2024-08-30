import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia/features/home/data/service/story_service.dart';
import 'package:socia/features/home/presentation/bloc/story_list_bloc/story_list_event.dart';
import 'package:socia/features/home/presentation/bloc/story_list_bloc/story_list_state.dart';

class StoryListBloc extends Bloc<StoryListEvent, StoryListState> {
  StoryService storyService;

  StoryListBloc({required this.storyService})
      : super(InitializeListStoryState()) {
    on<LoadStoryListEvent>(
        (event, emit) async => await onLoadStoryListEvent(event, emit));
  }

  onLoadStoryListEvent(event, emit) async {
    emit(LoadingListStoryState());
    await storyService.requestToGetStoryList().then(
      (bool value) {
        if (value) {
          emit(LoadStoryListState(
              imageListing: storyService.imageList,
              userList: storyService.userList));
        } else {
          emit(FailureStoryListState(errorMessage: storyService.errorMessage));
          log(storyService.errorMessage);
        }
      },
    );
  }
}
