import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia/core/extention/size_extention.dart';
import 'package:socia/core/widgets/snacbar.dart';
import 'package:socia/features/home/presentation/bloc/get_post_bloc/get_post_bloc.dart';
import 'package:socia/features/home/presentation/bloc/get_post_bloc/get_post_state.dart';

import 'home_page_timeline_post.dart';

class HomePagePostBuilder extends StatelessWidget {
  const HomePagePostBuilder({
    super.key,
    required GetPostBloc getPostBloc,
  }) : _getPostBloc = getPostBloc;

  final GetPostBloc _getPostBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _getPostBloc,
      child: BlocListener<GetPostBloc, GetPostState>(
        listener: (context, state) {
          if (state is LoadingGetPostState) {
            const Center(child: CupertinoActivityIndicator());
          } else if (state is FailureGetPostState) {
            snackBarMessage(
              context: context,
              title: state.failureMessage,
              isColorRed: true,
            );
          }
        },
        child: BlocBuilder<GetPostBloc, GetPostState>(
          builder: (context, state) {
            if (state is LoadedGetPostState) {
              return ListView.builder(
                itemCount: state.postListModal.length,
                itemBuilder: (BuildContext context, int index) {
                  final postListIndex = state.postListModal[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      top: 10.rH,
                      bottom: 8.rH,
                      left: 5.rW,
                      right: 5.rW,
                    ),
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      child: Container(
                        width: 365.rW,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.rP),
                          color: Theme.of(context).colorScheme.surface,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.shadow,
                              blurRadius: 1.0,
                              spreadRadius: 1.0,
                              offset: const Offset(1, 1),
                            )
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
    );
  }

  Text _errorFunction(state) {
    if (state is FailureGetPostState) {
      return Text(state.failureMessage);
    }
    return const Text('');
  }
}
