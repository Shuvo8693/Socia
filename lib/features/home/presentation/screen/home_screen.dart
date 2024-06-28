import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socia/home_screen_imports.dart';
import '../bloc/get_post_bloc/get_post_event.dart';
import '../bloc/story_list_bloc/story_list_bloc.dart';
import '../bloc/story_list_bloc/story_list_event.dart';
import '../widget/home_page_appbar.dart';
import '../widget/home_page_story.dart';
import '../widget/home_page_timeline_post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.currentNavigatorIndex});

  final int? currentNavigatorIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _commentsTEC = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? imageFile;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<GetPostBloc>().add(LoadedGetPostEvent());
      context.read<StoryBloc>().add(ImageAndProfileLoadStoryEvent());
      context.read<StoryListBloc>().add(LoadStoryListEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.currentNavigatorIndex == 2 ? uploadImage() : null;
    });
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: Column(
            children: [
              const SizedBox(
                height: 178,
                width: double.infinity,
                child: HomePageStory(),
              ),
              SizedBox(
                height: height * 0.56,
                width: 368,
                child: BlocBuilder<GetPostBloc, GetPostState>(
                  builder: (BuildContext context, state) {
                    if (state is LoadingGetPostState) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    } else if (state is FailureGetPostState) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 8, left: 5, right: 5),
                            child: AnimatedSize(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                              child: Container(
                                width: 365,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .shadow,
                                          blurRadius: 1.0,
                                          spreadRadius: 0.0,
                                          offset: const Offset(1, 2))
                                    ]),
                                child: TimeLinePostElement(
                                    postListIndex: postListIndex,
                                    commentsTEC: _commentsTEC),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Something went wrong...'),
                        errorFunction(state)
                      ],
                    ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text errorFunction(state) {
    if (state is FailureGetPostState) {
      return Text(state.failureMessage);
    }
    return const Text('');
  }

  void uploadImage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                const Text('Select From',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SvgInkButton(
                            assetPath: AppIcons.camera,
                            isBGSurfaceWhite: true,
                            onTap: () async {
                              XFile? pickCameraImage = await _imagePicker
                                  .pickImage(source: ImageSource.camera);
                              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                if(mounted){
                                  Navigator.pop(context);
                                }
                              });
                              },
                            pictureHeight: 88,
                            pictureWidth: 88,
                          ),
                          const Text('Camera',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                        ],
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        children: [
                          SvgInkButton(
                            assetPath: AppIcons.gallery,
                            isBGSurfaceWhite: true,
                            onTap: () async {
                              XFile? pickGalleryImage = await _imagePicker
                                  .pickImage(source: ImageSource.gallery);
                              Navigator.pop(context);
                            },
                            pictureHeight: 88,
                            pictureWidth: 88,
                          ),
                          const Text(
                            'Gallery',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }



  @override
  void dispose() {
    super.dispose();
    _commentsTEC.dispose();
  }
}


