import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia/features/home/data/service/get_post_service.dart';
import 'package:socia/features/home/presentation/bloc/get_post_bloc/get_post_state.dart';

import 'get_post_event.dart';

class GetPostBloc extends Bloc<GetPostEvent, GetPostState> {
  final GetPostService getPostService;

  GetPostBloc({required this.getPostService})
      : super(InitializedGetPostState()) {
    on<LoadedGetPostEvent>(
        (event, emit) async => await onLoadGetPostEvent(event, emit));
  }

  Future<void> onLoadGetPostEvent(event, emit) async {
     emit(LoadingGetPostState());
    await for (var result in getPostService.fetchPost()) {
      return result.fold((failure) {
        return emit(FailureGetPostState(failure));
      }, (postList) {
        return emit(LoadedGetPostState(postListModal: postList));
      });
    }
  }
}
