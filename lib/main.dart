
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socia/core/widgets/BottomNavBarScreen.dart';
import 'package:socia/core/widgets/loading_bar.dart';
import 'package:socia/features/home/presentation/screen/home_screen.dart';
import 'package:socia/features/post/presentation/screen/upload_content.dart';
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
      theme: themeData(),
      home:  const BottomNavBarScreen(),
    );
  }
}




