import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socia/home_screen_imports.dart';

import '../../../message/presentation/screen/message_screen.dart';
import '../bloc/get_post_bloc/get_post_event.dart';
import '../bloc/story_list_bloc/story_list_bloc.dart';
import '../bloc/story_list_bloc/story_list_event.dart';
import '../widget/home_page_story.dart';

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
  bool isExpanded = false;

  void toggleTextExpanded() {
    isExpanded = !isExpanded;
    setState(() {});
  }

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
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              profileUpdateAlert();
            },
            child: ClipOval(
              child: Image.network(
                DummyUrlImage.profile,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: SizedBox(
            height: 30,
            width: 223,
            child: Image.asset(
              AppLogo.logo,
              fit: BoxFit.scaleDown,
              color: Theme.of(context).colorScheme.onPrimary,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: SvgFabButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationScreen()));
                },
                assetPath: AppIcons.notification,
                fabBgColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              child: SvgFabButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MessageScreen()));
                },
                assetPath: AppIcons.message,
                fabBgColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : null,
              ),
            ),
          ),
        ],
      ),
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: postListIndex
                                                .profilePictureURL.isEmpty
                                            ? const AssetImage(
                                                    'assets/images/personBgRemove.png')
                                                as ImageProvider
                                            : NetworkImage(postListIndex
                                                .profilePictureURL),
                                        backgroundColor: Colors.grey,
                                      ),
                                      title: postListIndex.displayName.isEmpty
                                          ? const Text('DisplayName')
                                          : Text(postListIndex.displayName),
                                      subtitle: postListIndex.userName.isEmpty
                                          ? const Text('UserName')
                                          : Text(postListIndex.userName),
                                      trailing: CircleAvatar(
                                        child: SvgFabButton(
                                          onPressed: () {},
                                          assetPath: AppIcons.notification,
                                          fabBgColor:
                                              Theme.of(context).brightness ==
                                                      Brightness.dark
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .surface
                                                  : null,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(
                                        postListIndex.caption,
                                        overflow: isExpanded
                                            ? TextOverflow.visible
                                            : TextOverflow.ellipsis,
                                        maxLines: isExpanded ? null : 2,
                                      ),
                                    ),
                                    postListIndex.caption.isEmpty
                                        ? const SizedBox.shrink()
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: GestureDetector(
                                              onTap: () {
                                                toggleTextExpanded();
                                              },
                                              child: isExpanded
                                                  ? const Text('See less',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .blueAccent))
                                                  : const Text(
                                                      'See more',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .blueAccent),
                                                    ),
                                            ),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      child: Container(
                                        height: 300,
                                        width: 365,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  postListIndex.imageUrl,
                                                ),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                          children: [
                                            SvgInkButton(
                                              onTap: () {},
                                              assetPath: AppIcons.loveLine,
                                              top: 8,
                                              left: 8,
                                            ),
                                            SvgInkButton(
                                              onTap: () =>
                                                  commentsBottomSheet(context),
                                              assetPath: AppIcons.comment,
                                              top: 8,
                                              left: 15,
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(12.0),
                                              child: Text('Comments'),
                                            )
                                          ],
                                        ),
                                        SvgInkButton(
                                          onTap: () {},
                                          assetPath: AppIcons.bookmark,
                                          right: 8,
                                          top: 8,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: SizedBox(
                                        height: 65,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: 32,
                                              width: 32,
                                              child: CircleAvatar(
                                                backgroundImage: postListIndex
                                                        .profilePictureURL
                                                        .isEmpty
                                                    ? const AssetImage(
                                                            'assets/images/personBgRemove.png')
                                                        as ImageProvider
                                                    : NetworkImage(postListIndex
                                                        .profilePictureURL),
                                                backgroundColor: Colors.grey,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: CommonFormField(
                                                controller: _commentsTEC,
                                                hintText: 'Write Comment...',
                                              ),
                                            ),
                                            TextButton(
                                                onPressed: () {},
                                                child: const Text(
                                                  'Post',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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

  void commentsBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: Container(
                      height: 4,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(3)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Comments',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Divider(
                    height: 2,
                  ),
                  SizedBox(
                    height: 375,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: SizedBox(
                                    height: 32,
                                    width: 32,
                                    child: ClipOval(
                                      child: Image.network(
                                        DummyUrlImage.profile,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'UserName',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text('2 hours ago'),
                                      ],
                                    ),
                                    Text('Nice pictures of your travel',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ],
                            ),
                            SvgInkButton(
                                assetPath: AppIcons.loveLine, onTap: () {})
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      height: 65,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 32,
                            width: 32,
                            child: ClipOval(
                              child: Image.network(
                                DummyUrlImage.profile,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: CommonFormField(
                              controller: _commentsTEC,
                              hintText: 'Write Comment...',
                            ),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Post',
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
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
                              Navigator.pop(context);
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

  void profileUpdateAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return ProfileUpdateDialog(
            onPressed: () {},
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _commentsTEC.dispose();
  }
}
