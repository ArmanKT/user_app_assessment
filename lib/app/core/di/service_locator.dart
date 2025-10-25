import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:user_app_assessment/app/core/network/api_client.dart';
import 'package:user_app_assessment/app/core/service/hive_service.dart';
import 'package:user_app_assessment/app/features/user_list/data/datasources/users_list_local_data_source.dart';
import 'package:user_app_assessment/app/features/user_list/data/datasources/users_list_remote_data_source.dart';
import 'package:user_app_assessment/app/features/user_list/data/repositories/user_repository_impl.dart';
import 'package:user_app_assessment/app/features/user_list/domain/repositories/user_repository.dart';
import 'package:user_app_assessment/app/features/user_list/domain/usecase/user_date_usecase.dart';
import 'package:user_app_assessment/app/features/user_list/presentation/bloc/user_list_bloc.dart';
import 'package:user_app_assessment/app/features/splash/presentation/cubit/splash_cubit.dart';

/// Global instance of GetIt
final serviceLocator = GetIt.instance;

class ServiceLocator {
  /// Initialize all dependencies
  static Future<void> init() async {
    // Hive Service
    final hiveService = await HiveService.init();
    serviceLocator.registerSingleton<HiveService>(hiveService);
    // Connectivity
    serviceLocator.registerLazySingleton<Connectivity>(() => Connectivity());
    //Api Client
    serviceLocator.registerLazySingleton<ApiClient>(() => ApiClient());
    // Splash Cubit
    serviceLocator.registerFactory<SplashCubit>(() => SplashCubit());
    // User List
    serviceLocator.registerLazySingleton<UsersListRemoteDataSource>(() => UsersListRemoteDataSourceImpl(apiClient: serviceLocator()));
    serviceLocator.registerLazySingleton<UsersListLocalDataSource>(() => UsersListLocalDataSourceImpl(hiveService: serviceLocator()));

    serviceLocator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(usersListRemoteDataSource: serviceLocator(), usersListLocalDataSource: serviceLocator(), connectivity: serviceLocator()));
    serviceLocator.registerLazySingleton<UserDateUseCase>(() => UserDateUseCase(userRepository: serviceLocator()));
    serviceLocator.registerFactory<UserListBloc>(() => UserListBloc(userListDataUseCase: serviceLocator()));
    // UserList End
  }
}
