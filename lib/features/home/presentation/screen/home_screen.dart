import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socia/config/theme/app_icons.dart';
import 'package:socia/core/utility/dummypicturelink.dart';
import 'package:socia/core/utility/logo.dart';
import 'package:socia/core/widgets/button_text.dart';
import 'package:socia/core/widgets/svg_ink_button.dart';
import 'package:socia/features/notifications/presentation/screen/notification_screen.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../core/widgets/common_form_field.dart';
import '../../../../core/widgets/profile_update_alertdialog.dart';
import '../../../../core/widgets/svg_fab_button.dart';
import '../../../../core/widgets/home_screen_stroycard.dart';
import '../../../message/presentation/screen/message_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.currentNavigatorIndex});

  final int? currentNavigatorIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _commentsTEC = TextEditingController();
  final bool _shouldUseAddIcon = false;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('User');
  final ImagePicker _imagePicker = ImagePicker();
  XFile? imageFile;

  List<String> imageUrl = [
    'https://media.istockphoto.com/id/1001021150/photo/muslim-man-is-praying-in-mosque.webp?s=1024x1024&w=is&k=20&c=SjMLzeG1LbNne_wYOHM1rKem4K813PIhRg9yO02FTYo=',
    'https://media.istockphoto.com/id/1149556870/photo/muslim-man-is-praying-in-mosque.webp?s=1024x1024&w=is&k=20&c=J-6dfumiT0-kV4Enmn8yNt_Ya6vVSveLB9STauDrCjo=',
    'https://media.istockphoto.com/id/513115670/photo/religious-muslim-man-reading-holy-koran.webp?s=1024x1024&w=is&k=20&c=y7G--UCsp-PXsYX0lgkz79V4WJCKyyRU9EK71LnU9ko=',
    'https://media.istockphoto.com/id/1139230133/photo/man-holding-prayer-beads-while-praying-at-mosque.webp?s=1024x1024&w=is&k=20&c=rVxNrePkjrWmW79WCXpksmlre-gkOsBq_9ofgoJYw88=',
    'https://media.istockphoto.com/id/545376750/photo/young-muslim-man-praying.webp?s=1024x1024&w=is&k=20&c=wMNoAyiN7SbifRpiC7CoCpvDWGOSbkxO2DSa8VPf3-c=',
    'https://images.unsplash.com/photo-1560601575-29dc7d25ff3b?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://media.istockphoto.com/id/1311358706/photo/a-portrait-of-a-man-in-abdesthana-using-a-towel.webp?s=1024x1024&w=is&k=20&c=2z2BN7ZwZdsE3z_5fZgioBRWTnC8HKBXJqOYNtPR4wE=',
  ];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.currentNavigatorIndex == 2 ? uploadImage() : null;
    });

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              profileUpdateAlert();
            },
            child: ClipOval(
              child: Image.network(
                DummyUrlImage.profile,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: SizedBox(
            height: 30,
            width: 223,
            child: Image.asset(
              AppLogo.logo,
              fit: BoxFit.scaleDown,
              color: Theme.of(context).colorScheme.onPrimary,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: SvgFabButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationScreen()));
                },
                assetPath: AppIcons.notification,
                fabBgColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              child: SvgFabButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MessageScreen()));
                },
                assetPath: AppIcons.message,
                fabBgColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : null,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 186,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StoryCard(
                        imageIndex: imageUrl.first,
                        shouldUseAddIcon: true,
                        onTab: () {},
                        text: 'me'),
                    Flexible(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: imageUrl.length,
                          itemBuilder: (context, index) {
                            final imageIndex = imageUrl[index];
                            return StoryCard(
                              imageIndex: imageIndex,
                              shouldUseAddIcon: _shouldUseAddIcon,
                              onTab: () {},
                              text: 'User Name',
                            );
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                height: 471,
                width: 365,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).colorScheme.shadow,
                          blurRadius: 1.0,
                          spreadRadius: 0.0,
                          offset: const Offset(1, 1))
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(DummyUrlImage.profile),
                        backgroundColor: Colors.grey,
                      ),
                      title: const Text('Display Name'),
                      subtitle: const Text('UserName21'),
                      trailing: CircleAvatar(
                        child: SvgFabButton(
                          onPressed: () {},
                          assetPath: AppIcons.notification,
                          fabBgColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Theme.of(context).colorScheme.surface
                                  : null,
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
                            image: const DecorationImage(
                                image: NetworkImage(
                                  'https://images.unsplash.com/photo-1560601575-29dc7d25ff3b?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Expanded(
                      child: Row(
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
                                onTap: () => commentsBottomSheet(context),
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
                                controller: _commentsTEC,
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                              controller: _commentsTEC,
                              hintText: 'Write Comment...',
                            ),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Post',
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void uploadImage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                const Text('Select From',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SvgInkButton(
                            assetPath: AppIcons.camera,
                            isBGSurfaceWhite: true,
                            onTap: () async {
                              XFile? pickCameraImage = await _imagePicker
                                  .pickImage(source: ImageSource.camera);
                              Navigator.pop(context);
                            },
                            pictureHeight: 88,
                            pictureWidth: 88,
                          ),
                          const Text('Camera',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                        ],
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        children: [
                          SvgInkButton(
                            assetPath: AppIcons.gallery,
                            isBGSurfaceWhite: true,
                            onTap: () async {
                              XFile? pickGalleryImage = await _imagePicker
                                  .pickImage(source: ImageSource.gallery);
                              Navigator.pop(context);
                            },
                            pictureHeight: 88,
                            pictureWidth: 88,
                          ),
                          const Text(
                            'Gallery',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void profileUpdateAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return ProfileUpdateDialog(
            onPressed: () {},
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _commentsTEC.dispose();
  }
}
