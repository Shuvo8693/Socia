import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia/config/theme/app_icons.dart';
import 'package:socia/core/extention/size_extention.dart';
import 'package:socia/core/widgets/button/svg_ink_button.dart';
import 'package:socia/core/widgets/snacbar.dart';
import 'package:socia/features/home/data/model/post.dart';
import 'package:socia/features/home/data/service/commentcounter_service.dart';
import 'package:socia/features/home/data/service/like_post_get_service.dart';
import 'package:socia/features/home/data/service/like_submission_service.dart';
import 'package:socia/features/home/presentation/bloc/comment_count_cubit/comment_count_cubit.dart';
import 'package:socia/features/home/presentation/bloc/comment_count_cubit/comment_counter_state.dart';
import 'package:socia/features/home/presentation/bloc/like/like_cubit.dart';
import 'package:socia/features/home/presentation/bloc/like/like_state.dart';
import 'package:socia/features/home/presentation/widget/user_comments_bottomsheet/comment_display_section.dart';
import 'package:socia/features/home/presentation/widget/user_comments_bottomsheet/write_comment_section.dart';
import 'package:socia/injection_container.dart';

class LikeComment extends StatefulWidget {
  const LikeComment({super.key, required PostList postList})
      : _postList = postList;
  final PostList _postList;

  @override
  State<LikeComment> createState() => _LikeCommentState();
}

class _LikeCommentState extends State<LikeComment> {
  final LikeCubit _likeBloc =
      LikeCubit(di<LikeSubmissionService>(), di<LikePostGetService>());
  final CommentCountCubit _commentCountCubit =
      CommentCountCubit(di<CommentCounterService>());

  @override
  void initState() {
    super.initState();
    _likeBloc.updateLikePost(context, widget._postList.userId);
    _commentCountCubit.mapToCommentCounter(widget._postList.userId);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (__) => _likeBloc),
        BlocProvider(create: (__) => _commentCountCubit),
      ],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            children: [
              BlocBuilder<LikeCubit, LikeState>(
                builder: (context, state) {
                  if (state.errorMessage != null) {
                    WidgetsBinding.instance.addPostFrameCallback((__) {
                      snackBarMessage(
                          context: context, title: state.errorMessage ?? '');
                    });
                  }
                  bool isLiked = state.isLiked;
                  int likeCount = state.likeCount;
                  return Wrap(
                    children: [
                      SvgInkButton(
                        onTap: () async {
                          await _likeBloc.toggleLike(
                              context, widget._postList.userId);
                        },
                        assetPath: isLiked == true
                            ? AppIcons.loveFill
                            : AppIcons.loveLine,
                        isColorRed: isLiked,
                        top: 9.rH,
                        left: 9.rW,
                      ),
                      likeCount > 0
                          ? Padding(
                              padding: EdgeInsets.only(left: 8.rW, top: 12.rH),
                              child: Text(likeCount.toString()))
                          : const SizedBox.shrink(),
                    ],
                  );
                },
              ),
              BlocBuilder<CommentCountCubit, CommentCounterState>(
                builder: (BuildContext context, state) {
                  if (state.errorMessage != null) {
                    return buildCommentButton(context, state);
                  }
                  return buildCommentButton(context, state);
                },
              ),
            ],
          ),
          SvgInkButton(
            onTap: () {},
            assetPath: AppIcons.bookmark,
            right: 10.rW,
            top: 2.rH,
          ),
        ],
      ),
    );
  }

  Wrap buildCommentButton(BuildContext context, CommentCounterState state) {
    return Wrap(
      children: [
        SvgInkButton(
            onTap: () => commentsBottomSheet(context, widget._postList.userId),
            assetPath: AppIcons.comment,
            top: 9.rH,
            left: 15.rW),
        state.commentCount > 0
            ? Padding(
                padding: EdgeInsets.only(left: 8.rW, top: 12.rH),
                child: Text(state.commentCount.toString()),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  void commentsBottomSheet(BuildContext context, String postId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          widthFactor: 0.95,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.rH, bottom: 16.rH),
                    child: Container(
                      height: 4.rH,
                      width: 45.rW,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(3.rP)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.rH),
                    child: Text(
                      'Comments',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Divider(height: 2.rH),
                  CommentsDisplaySection(
                    postId: postId,
                  ),
                  Divider(height: 2.rH),
                  WriteCommentSection(
                    postId: postId,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
