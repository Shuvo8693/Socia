import 'package:flutter/material.dart';
import 'package:socia/config/theme/app_color.dart';
import 'package:socia/core/extention/size_extention.dart';
import 'package:socia/features/home/data/service/display_comment_service.dart';
import 'package:socia/features/home/presentation/bloc/display_comment_bloc/display_comment_bloc.dart';
import 'package:socia/features/home/presentation/bloc/display_comment_bloc/display_comment_event.dart';
import 'package:socia/features/home/presentation/bloc/display_comment_bloc/display_comment_state.dart';
import 'package:socia/home_screen_imports.dart';
import 'package:socia/injection_container.dart';

import 'display_comment_builder.dart';

class CommentsDisplaySection extends StatefulWidget {
  const CommentsDisplaySection({
    super.key,
    required this.postId,
  });

  final String postId;

  @override
  State<CommentsDisplaySection> createState() => _CommentsDisplaySectionState();
}

class _CommentsDisplaySectionState extends State<CommentsDisplaySection> {
  final DisplayCommentBloc _displayCommentBloc =
      DisplayCommentBloc(di<DisplayCommentService>());

  @override
  void initState() {
    super.initState();
    _displayCommentBloc.add(ListenToDisplayCommentEvent(widget.postId));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 375.rH,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.rW, vertical: 3.rH),
        child: BlocProvider(
          create: (_) => _displayCommentBloc,
          child: BlocBuilder<DisplayCommentBloc, DisplayCommentState>(
            builder: (BuildContext context, state) {
              if (state is LoadingDisplayCommentState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              } else if (state is ErrorDisplayCommentState) {
                return Center(child: Text(state.errorMessage));
              } else if (state is LoadedDisplayCommentState) {
                return DisplayCommentBuilder(
                  commentList: state.commentList,
                );
              }
              return const Text('Something went wrong');
            },
          ),
        ),
      ),
    );
  }
}
