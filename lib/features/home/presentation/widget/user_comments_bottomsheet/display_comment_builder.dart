import 'package:flutter/material.dart';
import 'package:socia/config/theme/app_icons.dart';
import 'package:socia/core/extention/size_extention.dart';
import 'package:socia/core/time_formation/data_age_formation.dart';
import 'package:socia/core/time_formation/difference_formation.dart';
import 'package:socia/core/widgets/button/svg_ink_button.dart';
import 'package:socia/core/widgets/spacing/spacing.dart';
import 'package:socia/features/home/data/model/comment.dart';

class DisplayCommentBuilder extends StatefulWidget {
  const DisplayCommentBuilder({
    super.key,
    required List<Comment> commentList,
  }) : _commentList = commentList;

  final List<Comment> _commentList;

  @override
  State<DisplayCommentBuilder> createState() => _DisplayCommentBuilderState();
}

class _DisplayCommentBuilderState extends State<DisplayCommentBuilder> {
  final DataAgeFormation _ageFormation = DataAgeFormation();
  final DifferenceFormation _differenceFormation = DifferenceFormation();


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget._commentList.length,
      itemBuilder: (BuildContext context, int index) {
        final commentIndex = widget._commentList[index];
        Duration timeDifference =
            _differenceFormation.formatDifference(commentIndex.createdTime);
        return Column(
          children: [
            Row(
              children: [
                Wrap(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.rW),
                      child: SizedBox(
                        height: 32.rH,
                        width: 32.rH,
                        child: ClipOval(
                          child: Image.network(
                            commentIndex.profilePictureUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              commentIndex.displayName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            const Text(
                              '\u2022',
                              style: TextStyle(color: Colors.grey),
                            ),
                            horizontalSpace(5.rW),
                            Text(
                              _ageFormation.formatContentAge(timeDifference),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 280.rW,
                          child: Text(
                            commentIndex.content,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                horizontalSpace(20.rW),
                SvgInkButton(
                  assetPath: AppIcons.loveLine,
                  onTap: () {},
                )
              ],
            ),
            verticalSpace(10.rH)
          ],
        );
      },
    );
  }
}
