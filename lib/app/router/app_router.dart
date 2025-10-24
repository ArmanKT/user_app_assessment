import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:user_app_assessment/app/features/home/presentation/home_screen.dart';
import 'package:user_app_assessment/app/features/splash/presentation/splash_screen.dart';
import 'route_helper.dart';

class AppRouter {
  final GoRouter _router;

  AppRouter()
      : _router = GoRouter(
          navigatorKey: navigatorKey,
          initialLocation: '/',
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const SplashScreen(),
            ),
            GoRoute(
              path: RouteHelper.homeScreen,
              name: RouteHelper.homeScreen,
              builder: (context, state) => HomeScreen(),
            ),
          ],
        );

  GoRouter get router => _router;

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext? get globalContext => navigatorKey.currentContext;
}
