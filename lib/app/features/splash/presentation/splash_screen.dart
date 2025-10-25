import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:user_app_assessment/app/components/image/my_asset_widget.dart';
import 'package:user_app_assessment/app/core/utils/utils_exporter.dart';
import 'package:user_app_assessment/app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:user_app_assessment/app/router/route_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animation setup
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true); // scale up and down

    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start splash cubit
    context.read<SplashCubit>().startSplash();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, bool>(
      listener: (context, finished) {
        if (finished) {
          // Navigate to HomeScreen using GoRouter
          context.go(RouteHelper.userListScreen);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: ScaleTransition(
            scale: _animation,
            child: Image.asset(
               AppImages.appIcon,
              width: 120,
              height: 120,
            ),
          ),
        ),
      ),
    );
  }
}
