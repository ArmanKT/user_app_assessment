import 'package:flutter/material.dart';
import 'package:user_app_assessment/app/core/di/bloc_observer.dart';
import 'package:user_app_assessment/app/core/di/service_locator.dart';
import 'package:user_app_assessment/app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:user_app_assessment/app/router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app_assessment/environment.dart';
import 'app/core/utils/utils_exporter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await ServiceLocator.init(); // initialize GetIt
  final appRouter = AppRouter(); // create it in main
  runApp(ArcApp(appRouter: appRouter));
}

class ArcApp extends StatelessWidget {
  final AppRouter appRouter;

  const ArcApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(create: (_) => serviceLocator<SplashCubit>()), //Splash Cubit Bloc
      ],
      child: MaterialApp.router(
        title: Environment.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerDelegate: appRouter.router.routerDelegate,
        routeInformationParser: appRouter.router.routeInformationParser,
        routeInformationProvider: appRouter.router.routeInformationProvider,
      ),
    );
  }
}
