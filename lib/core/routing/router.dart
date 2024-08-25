import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:socia/core/widgets/BottomNavBarScreen.dart';
import 'package:socia/core/widgets/splash_screen.dart';
import 'package:socia/features/authentication/presentation/screen/login_screen.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

abstract class Routers {
  static const String splashScreen = 'splash';
  static const String logInScreen = 'Login-screen';
  static const String baseScreen = 'Base-screen';

  static BuildContext? get globalNavigatorKey =>
      router.routerDelegate.navigatorKey.currentContext;

  static GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        name: splashScreen,
        path: '/splash',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
        routes: [_logInScreenRoute, _baseScreenRoute],
      ),
    ],
  );

  static final GoRoute _logInScreenRoute = GoRoute(
    name: logInScreen,
    path: logInScreen,
    builder: (BuildContext context, GoRouterState state) {
      String? isLogin = state.uri.queryParameters['isLogin'];
      return LogInScreen(isLogin: bool.parse(isLogin!));
    },
  );

  static final GoRoute _baseScreenRoute = GoRoute(
    name: baseScreen,
    path: baseScreen,
    builder: (BuildContext context, GoRouterState state) {
      return const BottomNavBarScreen();
    },
  );

  static void goNamed(
      {required String routeName,
      Map<String, String>? pathParam,
      Map<String, dynamic>? queryParam,
      Object? extra}) {
    return GoRouter.of(globalNavigatorKey!).goNamed(routeName,
        pathParameters: pathParam ?? {},
        queryParameters: queryParam ?? {},
        extra: extra);
  }

  static Future<Object?> pushNamed(
      {required String routeName,
      Map<String, String>? pathParam,
      Map<String, dynamic>? queryParam,
      Object? extra}) async {
    final queryParams =
        queryParam?.map((key, value) => MapEntry(key, value.toString())) ?? {};
    return await GoRouter.of(globalNavigatorKey!).pushNamed(routeName,
        pathParameters: pathParam ?? {},
        queryParameters: queryParams,
        extra: extra);
  }

  static Future<Object?> pushReplacementNamed(
      {required String routeName,
      Map<String, String>? pathParam,
      Map<String, dynamic>? queryParam,
      Object? extra}) async {
    return await GoRouter.of(globalNavigatorKey!).pushReplacementNamed(
        routeName,
        pathParameters: pathParam ?? {},
        queryParameters: queryParam ?? {},
        extra: extra);
  }

  static void pop({Object? object}) {
    if (GoRouter.of(globalNavigatorKey!).canPop()) {
      return GoRouter.of(globalNavigatorKey!).pop();
    }
  }
}
