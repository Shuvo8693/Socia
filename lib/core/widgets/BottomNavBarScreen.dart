import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socia/config/theme/app_color.dart';
import 'package:socia/config/theme/app_icons.dart';
import 'package:socia/features/authentication/presentation/screen/login_screen.dart';
import 'package:socia/features/home/presentation/screen/home_screen.dart';
import 'package:socia/features/profile/presentation/screen/profile_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int currentIndex = 0;

  List<Widget> get allScreens=>[
    const HomeScreen(),
    const  LogInScreen(),
    HomeScreen(currentNavigatorIndex: currentIndex,),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child:allScreens.elementAt(currentIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index){
          currentIndex=index;
          setState(() {});
        },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          fixedColor: AppColors.primaryColor,
          selectedIconTheme: const IconThemeData(color: AppColors.primaryColor,),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.home,
                width: 24,
                height: 24,
                colorFilter: currentIndex == 0
                    ? const ColorFilter.mode(
                        AppColors.primaryColor, BlendMode.srcIn)
                    : null,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.search,
                  width: 24,
                  height: 24,
                  colorFilter: currentIndex == 1
                      ? const ColorFilter.mode(
                          AppColors.primaryColor, BlendMode.srcIn)
                      : null,
                ),
                label: 'Search'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.add,
                  width: 24,
                  height: 24,
                  colorFilter: currentIndex == 2
                      ? const ColorFilter.mode(
                          AppColors.primaryColor, BlendMode.srcIn)
                      : null,
                ),
                label: 'Add Post'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.profile,
                  width: 24,
                  height: 24,
                  colorFilter: currentIndex == 3
                      ? const ColorFilter.mode(
                          AppColors.primaryColor, BlendMode.srcIn)
                      : null,
                ),
                label: 'Profile'),
          ]),
    );
  }
}
