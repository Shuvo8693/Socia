import 'package:flutter/material.dart';
import 'package:socia/core/extention/size_extention.dart';
import 'package:socia/core/utility/assets_image.dart';
import 'package:socia/core/widgets/spacing/spacing.dart';
import 'package:socia/features/home/presentation/widget/home_page_timeline_post.dart';
import 'package:socia/home_screen_imports.dart';

class WriteCommentPostSection extends StatefulWidget {
  const WriteCommentPostSection({
    super.key,
    required this.widget,
  });

  final TimeLinePostElement widget;

  @override
  State<WriteCommentPostSection> createState() =>
      _WriteCommentPostSectionState();
}

class _WriteCommentPostSectionState extends State<WriteCommentPostSection> {
  final TextEditingController _commentsTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 9.rW),
      child: SizedBox(
        height: 68.rH,
        child: Row(
          children: [
            SizedBox(
              height: 32.rH,
              width: 32.rH,
              child: CircleAvatar(
                backgroundImage:
                    widget.widget.postListIndex.profilePictureURL.isEmpty
                        ? AssetImage(AssetImg.noPersonImg) as ImageProvider
                        : NetworkImage(
                            widget.widget.postListIndex.profilePictureURL),
                backgroundColor: Colors.grey,
              ),
            ),
            verticalSpace(8.rH),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _commentsTEC.dispose();
  }
}
