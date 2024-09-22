import 'package:get_it/get_it.dart';
import 'package:socia/features/authentication/data/service/auth_login_service.dart';
import 'package:socia/features/authentication/data/service/auth_register_service.dart';
import 'package:socia/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:socia/features/home/data/service/comment_submission_service.dart';
import 'package:socia/features/home/data/service/commentcounter_service.dart';
import 'package:socia/features/home/data/service/display_comment_service.dart';
import 'package:socia/features/home/data/service/like_post_get_service.dart';
import 'package:socia/features/home/data/service/like_submission_service.dart';
import 'package:socia/features/home/data/service/profileimage_service.dart';
import 'package:socia/features/home/presentation/bloc/comment_count_cubit/comment_count_cubit.dart';
import 'package:socia/features/home/presentation/bloc/get_post_bloc/get_post_bloc.dart';
import 'package:socia/features/home/presentation/bloc/get_profileimage_bloc/profile_image_bloc.dart';
import 'package:socia/features/home/presentation/bloc/like/like_cubit.dart';
import 'package:socia/features/home/presentation/bloc/story_bloc/story_bloc.dart';
import 'package:socia/features/home/presentation/bloc/story_list_bloc/story_list_bloc.dart';
import 'package:socia/features/profile/data/service/update_profile_service.dart';
import 'package:socia/features/profile/presentation/bloc/update_profile_bloc.dart';

import 'features/home/data/service/add_story_service.dart';
import 'features/home/data/service/get_post_service.dart';
import 'features/home/data/service/story_service.dart';
import 'features/home/presentation/bloc/comment_submission_bloc/comment_bloc.dart';
import 'features/home/presentation/bloc/display_comment_bloc/display_comment_bloc.dart';

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

  /// ProfileImage
  di.registerFactory<ProfileImageService>(() => ProfileImageService());
  di.registerFactory<ProfileImageBloc>(
      () => ProfileImageBloc(di<ProfileImageService>()));

  /// Send Comment
  di.registerFactory<CommentSubmissionService>(() => CommentSubmissionService());
  di.registerFactory<CommentBloc>(() => CommentBloc(di()));

  /// Receive Display Comment
  di.registerFactory<DisplayCommentService>(() => DisplayCommentService());
  di.registerFactory<DisplayCommentBloc>(() => DisplayCommentBloc(di()));

  /// Received Comment Count
  di.registerFactory<CommentCounterService>(()=>CommentCounterService());
  di.registerFactory<CommentCountCubit>(()=>CommentCountCubit(di()));

  /// Like
  di.registerFactory<LikeSubmissionService>(() => LikeSubmissionService());
  di.registerFactory<LikePostGetService>(() => LikePostGetService());
  di.registerFactory<LikeCubit>(
      () => LikeCubit(di<LikeSubmissionService>(), di<LikePostGetService>()));

  /// -----Profile------
  di.registerFactory<UpdateProfileService>(() => UpdateProfileService());
  di.registerFactory<UpdateProfileBloc>(
      () => UpdateProfileBloc(updateProfileService: di()));
}
