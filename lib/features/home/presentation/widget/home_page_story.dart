import 'package:flutter/cupertino.dart';
import 'package:socia/core/extention/size_extention.dart';
import 'package:socia/features/home/presentation/bloc/story_list_bloc/story_list_bloc.dart';
import 'package:socia/features/home/presentation/bloc/story_list_bloc/story_list_state.dart';
import 'package:socia/home_screen_imports.dart';

class HomePageStory extends StatefulWidget {
  final StoryBloc _storyBloc;
  final StoryListBloc _storyListBloc;

  const HomePageStory({
    super.key,
    required StoryBloc storyBloc,
    required StoryListBloc storyListBloc,
  })  : _storyBloc = storyBloc,
        _storyListBloc = storyListBloc;

  @override
  State<HomePageStory> createState() => _HomePageStoryState();
}

class _HomePageStoryState extends State<HomePageStory> {
  XFile? _imageFile;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// user story area
        BlocProvider(
          create: (context) => widget._storyBloc,
          child: BlocBuilder<StoryBloc, StoryState>(
            builder: (BuildContext context, state) {
              if (state is LoadingStoryState) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (state is FailureStoryState) {
                Text(state.errorMessage);
              } else if (state is ImageProfileLoadStoryState) {
                return StoryCard(
                  imageIndex: state.image,
                  shouldUseAddIcon: true,
                  onTab: () async => await uploadStoryImage(context),
                  text: state.userList.first.userName,
                  image: state.userList.first.profilePictureURL,
                );
              }
              return const StoryCard(
                  imageIndex: '', shouldUseAddIcon: false, text: '', image: '');
            },
          ),
        ),

        /// Following storyList area
        BlocProvider(
          create: (context) => widget._storyListBloc,
          child: BlocBuilder<StoryListBloc, StoryListState>(
            builder: (BuildContext context, stateValue) {
              if (stateValue is LoadingListStoryState) {
                return Center(
                  widthFactor: 10.rW,
                  child: const CupertinoActivityIndicator(),
                );
              } else if (stateValue is FailureStoryListState) {
                return Text(stateValue.errorMessage);
              } else if (stateValue is LoadStoryListState) {
                final int itemCount =
                    stateValue.userList.length < stateValue.imageListing.length
                        ? stateValue.userList.length
                        : stateValue.imageListing.length;
                return Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      final imageListIndex = stateValue.imageListing[index];
                      final userListIndex = stateValue.userList[index];
                      return StoryCard(
                        imageIndex: imageListIndex,
                        shouldUseAddIcon: false,
                        text: userListIndex.userName,
                        image: userListIndex.profilePictureURL,
                      );
                    },
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  uploadStoryImage(BuildContext context) async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (!mounted) return;

    setState(() {
      _imageFile = pickedFile;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted == true && _imageFile != null) {
        widget._storyBloc.add(AddImageStoryEvent(
            image: _imageFile ?? XFile(''), context: context));
      }
    });
  }
}
