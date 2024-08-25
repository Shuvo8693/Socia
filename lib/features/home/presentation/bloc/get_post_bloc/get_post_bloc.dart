import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia/features/home/data/service/get_post_service.dart';
import 'package:socia/features/home/presentation/bloc/get_post_bloc/get_post_state.dart';

import 'get_post_event.dart';

class GetPostBloc extends Bloc<GetPostEvent, GetPostState> {
  GetPostBloc({required this.getPostService})
      : super(InitializedGetPostState()) {
    on<LoadedGetPostEvent>(
        (event, emit) async => await onLoadedGetPostEvent(event, emit));
  }

  final GetPostService getPostService;

  onLoadedGetPostEvent(event, emit) async {
    try {
      emit(LoadingGetPostState());
      await getPostService.fetchPost().then((bool value) async {
        if (value) {
          await emit(
              LoadedGetPostState(postListModal: getPostService.postListModal));
        } else {
          emit(FailureGetPostState(getPostService.errorMessage));
          log(getPostService.errorMessage);
        }
      });
    } catch (error, stackTrace) {
      emit(FailureGetPostState(stackTrace.toString()));
      log(stackTrace.toString());
    }
  }
}
