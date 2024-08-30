import 'package:flutter/material.dart';
import 'package:socia/config/theme/app_icons.dart';
import 'package:socia/core/extention/size_extention.dart';
import 'package:socia/core/widgets/button/svg_ink_button.dart';
import 'package:socia/features/home/presentation/widget/user_comments_bottomsheet/comment_display_section.dart';
import 'package:socia/features/home/presentation/widget/user_comments_bottomsheet/write_comment_section.dart';

class LikeComment extends StatelessWidget {
  const LikeComment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Wrap(
          children: [
            SvgInkButton(
              onTap: () {},
              assetPath: AppIcons.loveLine,
              top: 9.rH,
              left: 9.rW,
            ),
            SvgInkButton(
              onTap: () => commentsBottomSheet(context),
              assetPath: AppIcons.comment,
              top: 9.rH,
              left: 15.rW,
            ),
            Padding(
              padding: EdgeInsets.all(12.rP),
              child: const Text('Comments'),
            )
          ],
        ),
        SvgInkButton(
          onTap: () {},
          assetPath: AppIcons.bookmark,
          right: 10.rH,
          top: 9.rW,
        ),
      ],
    );
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
                CommentsDisplaySection(),
                Divider(height: 2.rH),
                WriteCommentSection()
              ],
            ),
          ),
        );
      },
    );
  }
}