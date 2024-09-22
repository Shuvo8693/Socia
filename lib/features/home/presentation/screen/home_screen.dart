import 'package:flutter/material.dart';
import 'package:socia/core/extention/size_extention.dart';
import 'package:socia/features/home/data/service/add_story_service.dart';
import 'package:socia/features/home/data/service/profileimage_service.dart';
import 'package:socia/features/home/data/service/story_service.dart';
import 'package:socia/features/home/presentation/bloc/get_post_bloc/get_post_event.dart';
import 'package:socia/features/home/presentation/bloc/get_profileimage_bloc/profile_image_bloc.dart';
import 'package:socia/features/home/presentation/bloc/get_profileimage_bloc/profile_image_event.dart';
import 'package:socia/features/home/presentation/bloc/story_list_bloc/story_list_bloc.dart';
import 'package:socia/features/home/presentation/bloc/story_list_bloc/story_list_event.dart';
import 'package:socia/features/home/presentation/widget/home_page_appbar.dart';
import 'package:socia/features/home/presentation/widget/home_page_post_builder.dart';
import 'package:socia/features/home/presentation/widget/home_page_story.dart';
import 'package:socia/features/home/presentation/widget/homepage_alertdialog.dart';
import 'package:socia/home_screen_imports.dart';
import 'package:socia/injection_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.currentNavigatorIndex});

  final int? currentNavigatorIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GetPostBloc _getPostBloc =
      GetPostBloc(getPostService: di<GetPostService>());
  final StoryBloc _storyBloc = StoryBloc(
      storyService: di<StoryService>(), addStoryService: di<AddStoryService>());
  final StoryListBloc _storyListBloc =
      StoryListBloc(storyService: di<StoryService>());
  final ProfileImageBloc _profileImageBloc =
      ProfileImageBloc(di<ProfileImageService>());

  final ImagePicker _imagePicker = ImagePicker();
  XFile? imageFile;

  @override
  void initState() {
    super.initState();
    _profileImageBloc.add(LoadProfileImageEvent());
    _getPostBloc.add(LoadedGetPostEvent());
    _storyBloc.add(ImageAndProfileLoadStoryEvent());
    _storyListBloc.add(LoadStoryListEvent());
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.currentNavigatorIndex == 2 ? _uploadImage() : null;
    });
    return Scaffold(
      appBar: HomeAppBar(profileImageBloc: _profileImageBloc),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 8.rH, left: 8.rW, right: 8.rW),
          child: Column(
            children: [
              SizedBox(
                height: 200.rH,
                width: double.infinity,
                child: HomePageStory(
                  storyBloc: _storyBloc,
                  storyListBloc: _storyListBloc,
                ),
              ),
              SizedBox(
                height: 545.rH,
                width: 410.rW,
                child: HomePagePostBuilder(getPostBloc: _getPostBloc),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _uploadImage() {
    showDialog(
      context: context,
      builder: (context) {
        return HomePageAlertDialog(imagePicker: _imagePicker, mounted: mounted);
      },
    );
  }
}
