import 'package:flutter/material.dart';
import 'package:socia/config/theme/app_icons.dart';
import 'package:socia/core/extention/size_extention.dart';
import 'package:socia/core/utility/assets_image.dart';
import 'package:socia/core/widgets/button/svg_fab_button.dart';
import 'package:socia/features/home/data/model/post_modal.dart';
import 'package:socia/features/home/presentation/widget/timeline_post_element/caption_expansion_indicator.dart';
import 'package:socia/features/home/presentation/widget/timeline_post_element/like_comment.dart';
import 'package:socia/features/home/presentation/widget/timeline_post_element/timeline_picture.dart';
import 'package:socia/features/home/presentation/widget/timeline_post_element/write_comment&post_section.dart';

class TimeLinePostElement extends StatefulWidget {
  const TimeLinePostElement({
    super.key,
    required this.postListIndex,
  });

  final PostList postListIndex;

  @override
  State<TimeLinePostElement> createState() => _TimeLinePostElementState();
}

class _TimeLinePostElementState extends State<TimeLinePostElement> {
  bool isExpanded = false;

  void toggleTextExpanded() {
    isExpanded = !isExpanded;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: widget.postListIndex.profilePictureURL.isEmpty
                ? AssetImage(AssetImg.noPersonImg) as ImageProvider
                : NetworkImage(widget.postListIndex.profilePictureURL),
            backgroundColor: Colors.grey,
          ),
          title: widget.postListIndex.displayName.isEmpty
              ? const Text('DisplayName')
              : Text(widget.postListIndex.displayName),
          subtitle: widget.postListIndex.userName.isEmpty
              ? const Text('UserName')
              : Text(widget.postListIndex.userName),
          trailing: CircleAvatar(
            child: SvgFabButton(
              onPressed: () {},
              assetPath: AppIcons.notification,
              fabBgColor: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).colorScheme.surface
                  : null,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.rW),
          child: Text(
            widget.postListIndex.caption,
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            maxLines: isExpanded ? null : 2,
          ),
        ),
        widget.postListIndex.caption.isEmpty
            ? const SizedBox.shrink()
            : CaptionExpansionIndicator(
                isExpanded: isExpanded,
                onPressed: () => toggleTextExpanded(),
              ),
        TimelinePicture(widget: widget),
        LikeComment(),
        WriteCommentPostSection(widget: widget),
      ],
    );
  }
}
