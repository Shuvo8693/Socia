

import 'dart:developer';
import 'package:socia/features/home/presentation/bloc/story_list_bloc/story_list_event.dart';
import 'package:socia/features/home/presentation/bloc/story_list_bloc/story_list_state.dart';
import '../../../../../home_screen_imports.dart';
import '../../../data/service/story_service.dart';

class StoryListBloc extends Bloc<StoryListEvent, StoryListState> {
  StoryListBloc({required this.storyService}) : super(InitializeListStoryState()) {
    on<LoadStoryListEvent>((event, emit) async=>await onLoadStoryListEvent(event,emit) );
  }

  StoryService storyService;

  onLoadStoryListEvent(event,emit) async{
    try{
      emit(LoadingListStoryState());
     await storyService.requestToGetStoryList().then((bool value) {
       if(value){
         emit(LoadStoryListState(imageListing: storyService.imageList, userList: storyService.userList));

       }else{
         emit(FailureStoryListState(errorMessage: storyService.errorMessage));
         log(storyService.errorMessage);
       }
     });
    }catch(error){
      log(error.toString());
      emit(FailureStoryListState(errorMessage: error.toString()));
    }
  }
}
