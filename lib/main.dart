import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia/core/routing/router.dart';
import 'package:socia/features/profile/data/service/update_profile_service.dart';
import 'package:socia/features/profile/presentation/bloc/update_profile_bloc.dart';
import 'package:socia/firebase_options.dart';
import 'package:socia/injection_container.dart';

import 'config/theme/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions());
  await initDi();
  runApp(const SocIa());
}

class SocIa extends StatelessWidget {
  const SocIa({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => UpdateProfileBloc(
                updateProfileService: UpdateProfileService())),
      ],
      child: MaterialApp.router(
        routerDelegate: Routers.router.routerDelegate,
        routeInformationParser: Routers.router.routeInformationParser,
        routeInformationProvider: Routers.router.routeInformationProvider,
        debugShowCheckedModeBanner: false,
        title: 'SocIa',
        theme: lightTheme(),
        darkTheme: darkTheme(),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
