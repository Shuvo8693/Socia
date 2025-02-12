import 'package:flutter/material.dart';
import 'package:socia/config/theme/app_icons.dart';
import 'package:socia/core/utility/dummypicturelink.dart';
import 'package:socia/core/widgets/app_bar_title.dart';
import 'package:socia/core/widgets/view_tile_profile_screen.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isViewNavigateGrid = false;
  bool _isViewNavigateList = false;

  void _toggleGridView() {
    _isViewNavigateGrid = true;
    _isViewNavigateList = false;
    setState(() {});
  }

  void _toggleListView() {
    _isViewNavigateList = true;
    _isViewNavigateGrid = false;
    setState(() {});
  }

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
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: AppBarTitle(title: 'My Profile')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 112,
                width: 375,
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        DummyUrlImage.profile,
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Display Name',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          Text('UserName21',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400)),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                stateItem('25', 'Post'),
                                bol(),
                                stateItem('254', 'Followers'),
                                bol(),
                                stateItem('100', 'Following'),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 2,
              thickness: 5,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade800
                  : Colors.grey.shade200,
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ViewTile(
                  onTap: () {
                    _toggleGridView();
                  },
                  text: 'Grid View',
                  svgIcon: AppIcons.grid,
                  rightPadding: 3,
                ),
                ViewTile(
                  onTap: () {
                    _toggleListView();
                  },
                  text: 'List View',
                  svgIcon: AppIcons.list,
                  leftPadding: 3,
                ),
              ],
            ),
            Divider(
              height: 1,
              color: Colors.grey.shade400,
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(
              height: 8,
            ),
            _isViewNavigateGrid
                ? Expanded(
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: imageUrl.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5),
                        itemBuilder: (context, index) {
                          final imageUelIndex = imageUrl[index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              imageUelIndex,
                              fit: BoxFit.cover,
                            ),
                          );
                        }),
                  )
                : _isViewNavigateList
                    ? Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: imageUrl.length,
                            itemBuilder: (context, index) {
                              final imageUelIndex = imageUrl[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    imageUelIndex,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }),
                      )
                    : Expanded(
                        child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: imageUrl.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5),
                            itemBuilder: (context, index) {
                              final imageUelIndex = imageUrl[index];
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  imageUelIndex,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }),
                      ),
          ],
        ),
      ),
    );
  }

  Widget stateItem(String count, String label) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: count,
          style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.w500)),
      const TextSpan(text: '  '),
      TextSpan(
          text: label,
          style: const TextStyle(
              fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w400)),
    ]));
  }

  bol() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Text(
        '•',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}
