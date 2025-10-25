import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:user_app_assessment/app/features/user_list/data/models/user_model.dart';
import 'package:user_app_assessment/app/features/user_list/presentation/screens/user_list_screen.dart';
import 'package:user_app_assessment/app/features/user_list/presentation/screens/user_details_screen.dart';
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
              path: RouteHelper.userListScreen,
              name: RouteHelper.userListScreen,
              builder: (context, state) => UserListScreen(),
            ),
            GoRoute(
              path: RouteHelper.userDetailsScreen,
              name: RouteHelper.userDetailsScreen,
              builder: (context, state) {
                // Get the UserModel from extra
                final user = state.extra as UserModel;
                return UserDetailPage(user: user);
              },
            ),
          ],
        );

  GoRouter get router => _router;

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext? get globalContext => navigatorKey.currentContext;
}
