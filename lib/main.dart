
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socia/core/widgets/BottomNavBarScreen.dart';
import 'package:socia/core/widgets/splash_screen.dart';
import 'package:socia/features/authentication/presentation/screen/login_screen.dart';
import 'package:socia/features/follow_unfollow/presentation/screen/folllow_unfollow.dart';
import 'package:socia/features/message/presentation/screen/message_screen.dart';
import 'package:socia/features/notifications/presentation/screen/notification_screen.dart';
import 'package:socia/features/post/presentation/screen/add_location.dart';
import 'package:socia/features/post/presentation/screen/upload_content.dart';
import 'package:socia/features/profile/presentation/screen/others_profile.dart';
import 'package:socia/features/search/presentation/screen/search_screen.dart';
import 'package:socia/firebase_options.dart';
import 'config/theme/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions());
  runApp(const SocIa());
}

class SocIa extends StatelessWidget {
  const SocIa({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SocIa',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      home:  const BottomNavBarScreen(),
    );
  }
}




