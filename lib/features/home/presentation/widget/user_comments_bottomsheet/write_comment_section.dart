import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socia/core/extention/size_extention.dart';
import 'package:socia/core/widgets/spacing/spacing.dart';
import 'package:socia/features/home/data/service/comment_submission_service.dart';
import 'package:socia/features/home/data/service/profileimage_service.dart';
import 'package:socia/features/home/presentation/bloc/comment_submission_bloc/comment_bloc.dart';
import 'package:socia/features/home/presentation/bloc/get_profileimage_bloc/profile_image_bloc.dart';
import 'package:socia/features/home/presentation/bloc/get_profileimage_bloc/profile_image_event.dart';
import 'package:socia/features/home/presentation/bloc/get_profileimage_bloc/profile_image_state.dart';
import 'package:socia/features/home/presentation/widget/user_comments_bottomsheet/write_commentsection_builder.dart';
import 'package:socia/home_screen_imports.dart';
import 'package:socia/injection_container.dart';

class WriteCommentSection extends StatefulWidget {
  const WriteCommentSection({
    super.key,
    required this.postId,
  });

  final String postId;

  @override
  State<WriteCommentSection> createState() => _WriteCommentSectionState();
}

class _WriteCommentSectionState extends State<WriteCommentSection> {
  final TextEditingController _commentsTEC = TextEditingController();
  final _key = GlobalKey<FormState>();
  final ProfileImageBloc _profileImageBloc =
      ProfileImageBloc(di<ProfileImageService>());
  final CommentBloc _commentBloc = CommentBloc(di<CommentSubmissionService>());
  String content = '';

  @override
  void initState() {
    super.initState();
    _profileImageBloc.add(LoadProfileImageEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _commentsTEC.addListener(_onContentChange);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.rW),
      child: SizedBox(
        height: 65.rH,
        child: Form(
          key: _key,
          child: Row(
            children: [
              SizedBox(
                height: 35.rH,
                width: 35.rH,
                child: ClipOval(
                  child: BlocProvider(
                    create: (context) => _profileImageBloc,
                    child: BlocBuilder<ProfileImageBloc, ProfileImageState>(
                      builder: (context, state) {
                        if (state is LoadingProfileImageState) {
                          return Image.asset(AppIcons.noImagePerson);
                        } else if (state is FailureProfileImageState) {
                          return Image.asset(AppIcons.noImagePerson);
                        } else if (state is LoadedProfileImageState) {
                          return Image.network(
                            state.imageData,
                            fit: BoxFit.cover,
                          );
                        } else {
                          return Image.asset(AppIcons.noImagePerson);
                        }
                      },
                    ),
                  ),
                ),
              ),
              horizontalSpace(8.rW),
              Expanded(
                child: CommonFormField(
                  controller: _commentsTEC,
                  hintText: 'Write Comment...',
                ),
              ),
              BlocProvider(
                create: (BuildContext context) => _commentBloc,
                child: WriteCommentSectionBuilder(
                  content: content,
                  globalKey: _key,
                  commentBloc: _commentBloc,
                  widget: widget,
                  commentsTEC: _commentsTEC,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onContentChange() {
    setState(() {
      content = _commentsTEC.text;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _commentsTEC.removeListener(_onContentChange);
    _commentsTEC.dispose();
  }
}


