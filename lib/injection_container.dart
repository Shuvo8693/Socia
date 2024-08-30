import 'package:get_it/get_it.dart';
import 'package:socia/features/authentication/data/service/auth_login_service.dart';
import 'package:socia/features/authentication/data/service/auth_register_service.dart';
import 'package:socia/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:socia/features/home/presentation/bloc/get_post_bloc/get_post_bloc.dart';
import 'package:socia/features/home/presentation/bloc/story_bloc/story_bloc.dart';
import 'package:socia/features/home/presentation/bloc/story_list_bloc/story_list_bloc.dart';

import 'features/home/data/service/add_story_service.dart';
import 'features/home/data/service/get_post_service.dart';
import 'features/home/data/service/story_service.dart';

final di = GetIt.instance;

Future<void> initDi() async {
  /// Authentication
  di.registerFactory<AuthLogInService>(() => AuthLogInService());
  di.registerFactory<AuthRegisterService>(() => AuthRegisterService());
  di.registerFactory<AuthBloc>(() => AuthBloc(
      authRegisterService: di<AuthRegisterService>(),
      authLogInService: di<AuthLogInService>()));

  ///----- Home-----
  ///Get timeline post
  di.registerFactory<GetPostService>(() => GetPostService());
  di.registerFactory<GetPostBloc>(
      () => GetPostBloc(getPostService: di<GetPostService>()));

  /// Story
  di.registerFactory<StoryService>(() => StoryService());
  di.registerFactory<AddStoryService>(() => AddStoryService());
  di.registerFactory<StoryBloc>(() => StoryBloc(
      storyService: di<StoryService>(),
      addStoryService: di<AddStoryService>()));

  ///Story List
  di.registerFactory<StoryListBloc>(
      () => StoryListBloc(storyService: di<StoryService>()));
}
