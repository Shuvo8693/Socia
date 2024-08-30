import 'package:flutter/material.dart';
import 'package:socia/core/extention/size_extention.dart';
import 'package:socia/features/home/presentation/widget/home_page_timeline_post.dart';

class TimelinePicture extends StatelessWidget {
  const TimelinePicture({
    super.key,
    required this.widget,
  });

  final TimeLinePostElement widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.rW),
      child: Container(
        height: 300.rH,
        width: 390.rW,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.rP),
          image: DecorationImage(
              image: NetworkImage(widget.postListIndex.imageUrl),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}