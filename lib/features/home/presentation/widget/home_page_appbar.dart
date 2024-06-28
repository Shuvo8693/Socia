import 'package:flutter/material.dart';
import 'package:socia/features/profile/presentation/screen/profile_screen.dart';
import 'package:socia/features/profile/presentation/screen/update_profile_screen.dart';
import '../../../../config/theme/app_icons.dart';
import '../../../../core/utility/dummypicturelink.dart';
import '../../../../core/utility/logo.dart';
import '../../../../core/widgets/profile_update_alertdialog.dart';
import '../../../../core/widgets/svg_fab_button.dart';
import '../../../message/presentation/screen/message_screen.dart';
import '../../../notifications/presentation/screen/notification_screen.dart';


class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const HomeAppBar({
    super.key,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
             profileUpdateAlert(context);
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
    );

  }
  void profileUpdateAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return ProfileUpdateDialog(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const UpdateProfileScreen()));
            },
          );
        });
  }
}
