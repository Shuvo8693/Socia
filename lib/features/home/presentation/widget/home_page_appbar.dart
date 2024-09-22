import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia/config/theme/app_icons.dart';
import 'package:socia/core/extention/size_extention.dart';
import 'package:socia/core/utility/logo.dart';
import 'package:socia/core/widgets/button/svg_fab_button.dart';
import 'package:socia/core/widgets/profile_update_alertdialog.dart';
import 'package:socia/features/home/presentation/bloc/get_profileimage_bloc/profile_image_bloc.dart';
import 'package:socia/features/home/presentation/bloc/get_profileimage_bloc/profile_image_state.dart';
import 'package:socia/features/message/presentation/screen/message_screen.dart';
import 'package:socia/features/notifications/presentation/screen/notification_screen.dart';
import 'package:socia/features/profile/presentation/screen/update_profile_screen.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final ProfileImageBloc profileImageBloc;

  const HomeAppBar({
    super.key,
    required this.profileImageBloc,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding:  EdgeInsets.all(8.0.rP),
        child: GestureDetector(
          onTap: () {
            profileUpdateAlert(context);
          },
          child: ClipOval(
            child: BlocProvider(
              create: (context) => profileImageBloc,
              child: BlocBuilder<ProfileImageBloc, ProfileImageState>(
                builder: (context, state) {
                  if(state is LoadingProfileImageState){
                    return Image.asset(AppIcons.noImagePerson);
                  } else if (state is FailureProfileImageState) {
                    return Image.asset(AppIcons.noImagePerson);
                  } else if (state is LoadedProfileImageState) {
                    return Image.network(
                      state.imageData,
                      fit: BoxFit.cover,
                    );
                  }else{
                    return Image.asset(AppIcons.noImagePerson);
                  }
                },
              ),
            ),
          ),
        ),
      ),
      title: SizedBox(
        height: 30.rH,
        width: 223.rW,
        child: Image.asset(
          AppLogo.logo,
          fit: BoxFit.scaleDown,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      actions: [
        Padding(
          padding:  EdgeInsets.all(8.0.rP),
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
          padding:  EdgeInsets.only(right: 10.rW),
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UpdateProfileScreen(),
              ),
            );
          },
        );
      },
    );
  }
}
