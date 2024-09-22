import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia/features/home/data/service/display_comment_service.dart';

import 'display_comment_event.dart';
import 'display_comment_state.dart';


class DisplayCommentBloc
    extends Bloc<DisplayCommentEvent, DisplayCommentState> {
  DisplayCommentService displayCommentService;

  DisplayCommentBloc(this.displayCommentService)
      : super(InitDisplayCommentState()){
    on<ListenToDisplayCommentEvent>((event,emit) async=> await listenToCommentEvent(event,emit));
  }

  Future<void> listenToCommentEvent(event,emit) async {
    emit(LoadingDisplayCommentState()) ;
    if (event is ListenToDisplayCommentEvent) {
      await for (var item in displayCommentService.fetchComment(event.postID)) {
         item.fold((error) {
          return emit(ErrorDisplayCommentState(error));
        }, (commentList) {
          return emit(LoadedDisplayCommentState(commentList));
        });
      }
    }
  }
}
