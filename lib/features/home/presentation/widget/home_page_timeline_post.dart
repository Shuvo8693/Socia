import 'package:flutter/material.dart';
import 'package:socia/config/theme/app_icons.dart';
import 'package:socia/core/utility/assets_image.dart';
import 'package:socia/core/utility/dummypicturelink.dart';
import 'package:socia/core/widgets/button/svg_fab_button.dart';
import 'package:socia/core/widgets/button/svg_ink_button.dart';
import 'package:socia/core/widgets/common_form_field.dart';
import 'package:socia/features/home/data/model/post_modal.dart';

class TimeLinePostElement extends StatefulWidget {
  const TimeLinePostElement({
    super.key,
    required this.postListIndex,
    required TextEditingController commentsTEC,
  }) : _commentsTEC = commentsTEC;

  final PostList postListIndex;
  final TextEditingController _commentsTEC;

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
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            widget.postListIndex.caption,
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            maxLines: isExpanded ? null : 2,
          ),
        ),
        widget.postListIndex.caption.isEmpty
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () {
                    toggleTextExpanded();
                  },
                  child: isExpanded
                      ? const Text('See less',
                          style: TextStyle(color: Colors.blueAccent))
                      : const Text(
                          'See more',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                ),
              ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Container(
            height: 300,
            width: 365,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: NetworkImage(
                      widget.postListIndex.imageUrl,
                    ),
                    fit: BoxFit.cover)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              children: [
                SvgInkButton(
                  onTap: () {},
                  assetPath: AppIcons.loveLine,
                  top: 8,
                  left: 8,
                ),
                SvgInkButton(
                  onTap: () {
                    commentsBottomSheet(context);
                  },
                  assetPath: AppIcons.comment,
                  top: 8,
                  left: 15,
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Comments'),
                )
              ],
            ),
            SvgInkButton(
              onTap: () {},
              assetPath: AppIcons.bookmark,
              right: 8,
              top: 8,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(
            height: 65,
            child: Row(
              children: [
                SizedBox(
                  height: 32,
                  width: 32,
                  child: CircleAvatar(
                    backgroundImage: widget
                            .postListIndex.profilePictureURL.isEmpty
                        ? AssetImage(AssetImg.noPersonImg) as ImageProvider
                        : NetworkImage(widget.postListIndex.profilePictureURL),
                    backgroundColor: Colors.grey,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: CommonFormField(
                    controller: widget._commentsTEC,
                    hintText: 'Write Comment...',
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Post',
                      style: TextStyle(fontSize: 18),
                    )),
              ],
            ),
          ),
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
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: Container(
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(3)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    'Comments',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                const Divider(
                  height: 2,
                ),
                SizedBox(
                  height: 375,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: SizedBox(
                                  height: 32,
                                  width: 32,
                                  child: ClipOval(
                                    child: Image.network(
                                      DummyUrlImage.profile,
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
                                        'UserName',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text('2 hours ago'),
                                    ],
                                  ),
                                  Text('Nice pictures of your travel',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ],
                          ),
                          SvgInkButton(
                              assetPath: AppIcons.loveLine, onTap: () {})
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    height: 65,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 32,
                          width: 32,
                          child: ClipOval(
                            child: Image.network(
                              DummyUrlImage.profile,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: CommonFormField(
                            controller: widget._commentsTEC,
                            hintText: 'Write Comment...',
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Post',
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
