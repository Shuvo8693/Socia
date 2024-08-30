import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socia/core/extention/size_extention.dart';
import 'package:socia/features/home/data/service/add_story_service.dart';
import 'package:socia/features/home/data/service/story_service.dart';
import 'package:socia/features/home/presentation/bloc/get_post_bloc/get_post_event.dart';
import 'package:socia/features/home/presentation/bloc/story_list_bloc/story_list_bloc.dart';
import 'package:socia/features/home/presentation/bloc/story_list_bloc/story_list_event.dart';
import 'package:socia/features/home/presentation/widget/home_page_appbar.dart';
import 'package:socia/features/home/presentation/widget/home_page_story.dart';
import 'package:socia/features/home/presentation/widget/home_page_timeline_post.dart';
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

  final ImagePicker _imagePicker = ImagePicker();
  XFile? imageFile;

  @override
  void initState() {
    super.initState();
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
      appBar: const HomeAppBar(),
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
                child: BlocProvider(
                  create: (context) => _getPostBloc,
                  child: BlocBuilder<GetPostBloc, GetPostState>(
                    builder: (BuildContext context, state) {
                      if (state is LoadingGetPostState) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      } else if (state is FailureGetPostState) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          snackBarMessage(
                              context: context,
                              title: state.failureMessage,
                              isColorRed: true);
                        });
                      } else if (state is LoadedGetPostState) {
                        return ListView.builder(
                          itemCount: state.postListModal.length,
                          itemBuilder: (BuildContext context, int index) {
                            final postListIndex = state.postListModal[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: 10.rH,
                                  bottom: 8.rH,
                                  left: 5.rW,
                                  right: 5.rW),
                              child: AnimatedSize(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                                child: Container(
                                  width: 365.rW,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.rP),
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .shadow,
                                          blurRadius: 1.0,
                                          spreadRadius: 1.0,
                                          offset: const Offset(1, 1))
                                    ],
                                  ),
                                  child: TimeLinePostElement(
                                    postListIndex: postListIndex,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Center(child: _errorFunction(state));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _errorFunction(state) {
    if (state is FailureGetPostState) {
      return Text(state.failureMessage);
    }
    return const Text('');
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
