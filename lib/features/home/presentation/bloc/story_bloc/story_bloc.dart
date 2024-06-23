import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia/features/home/data/service/add_story_service.dart';
import 'package:socia/features/home/data/service/story_service.dart';
import 'package:socia/features/home/presentation/bloc/story_bloc/story_event.dart';
import 'package:socia/features/home/presentation/bloc/story_bloc/story_state.dart';
import 'package:socia/features/home/presentation/bloc/story_list_bloc/story_list_event.dart';

import '../story_list_bloc/story_list_bloc.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc({required this.storyService, required this.addStoryService})
      : super(InitializeStoryState()) {
    on<ImageAndProfileLoadStoryEvent>(
        (event, emit) async => await onImageLoadStoryEvent(event, emit));
    on<AddImageStoryEvent>(
        (event, emit) async => await onAddImageStoryEvent(event, emit));
  }

  StoryService storyService;
  AddStoryService addStoryService;

  onImageLoadStoryEvent(event, emit) async {
    try {
      await storyService.requestToGetStoryImageAndProfile().then((bool value) {
        if (value) {
          emit(ImageProfileLoadStoryState(
            image: storyService.image,
            userList: storyService.userList,
          ));
        } else {
          emit(FailureStoryState(errorMessage: storyService.errorMessage));
        }
      });
    } catch (error) {
      emit(FailureStoryState(errorMessage: error.toString()));
    }
  }

  onAddImageStoryEvent(event, emit) async {
    try {
      if (event is AddImageStoryEvent) {
        emit(LoadingStoryState());
        await addStoryService
            .requestToUploadImageStory(event.image)
            .then((bool value) async {
          if (value) {
            event.context
                .read<StoryBloc>()
                .add(ImageAndProfileLoadStoryEvent());
            event.context.read<StoryListBloc>().add(LoadStoryListEvent());
          } else {
            emit(FailureStoryState(errorMessage: addStoryService.errorMessage));
          }
        });
      }
    } catch (error) {
      log(error.toString());
    }
  }
}
