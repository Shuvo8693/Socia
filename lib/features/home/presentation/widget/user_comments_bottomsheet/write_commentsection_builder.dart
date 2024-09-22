import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia/core/widgets/snacbar.dart';
import 'package:socia/features/home/presentation/bloc/comment_submission_bloc/comment_bloc.dart';
import 'package:socia/features/home/presentation/bloc/comment_submission_bloc/comment_event.dart';
import 'package:socia/features/home/presentation/bloc/comment_submission_bloc/comment_state.dart';
import 'package:socia/features/home/presentation/widget/user_comments_bottomsheet/write_comment_section.dart';

class WriteCommentSectionBuilder extends StatelessWidget {
  const WriteCommentSectionBuilder({
    super.key,
    required this.content,
    required GlobalKey<FormState> globalKey,
    required CommentBloc commentBloc,
    required this.widget,
    required TextEditingController commentsTEC,
  })  : _key = globalKey,
        _commentBloc = commentBloc,
        _commentsTEC = commentsTEC;

  final String content;
  final GlobalKey<FormState> _key;
  final CommentBloc _commentBloc;
  final WriteCommentSection widget;
  final TextEditingController _commentsTEC;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (BuildContext context, state) {
        if (state is LoadingCommentState) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state is FailureCommentState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            snackBarMessage(context: context, title: state.errorMessage);
          });
        } else if (state is LoadedCommentState) {
          return content.isNotEmpty
              ? TextButton(
                  onPressed: () {
                    if (!_key.currentState!.validate()) return;
                    _commentBloc.add(
                      LoadCommentEvent(
                        postID: widget.postId,
                        content: _commentsTEC.text,
                      ),
                    );
                    Future.delayed(
                      const Duration(seconds: 2),
                      () {
                        _commentsTEC.text = '';
                       // Navigator.pop(context);
                      },
                    );
                  },
                  child: const Text('Post', style: TextStyle(fontSize: 18)),
                )
              : const SizedBox.shrink();
        }
        return content.isNotEmpty
            ? TextButton(
                onPressed: () {
                  if (!_key.currentState!.validate()) return;
                  _commentBloc.add(
                    LoadCommentEvent(
                      postID: widget.postId,
                      content: _commentsTEC.text,
                    ),
                  );
                  Future.delayed(
                    const Duration(seconds: 2),
                    () {
                      _commentsTEC.text = '';
                      //Navigator.pop(context);
                    },
                  );
                },
                child: const Text('Post', style: TextStyle(fontSize: 18)),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
