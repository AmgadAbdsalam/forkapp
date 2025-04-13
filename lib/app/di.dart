import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:responsive/domain/use_cases/add_robot_to_database_usecase.dart';
import 'package:responsive/domain/use_cases/login_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_source/remote_data_source.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_factory.dart';
import '../data/network/network_info.dart';
import '../data/repository/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/use_cases/update_map_usecase.dart';
import 'app_prefs.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance<SharedPreferences>()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(InternetConnection()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();
  //app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
          () => RemoteDataSourceImpl(instance<AppServiceClient>()));

  // repository

  instance.registerLazySingleton<Repository>(
          () => RepositoryImpl(instance(), instance()));
}

Future<void> initLoginModule() async {
  if(!GetIt.I.isRegistered<LoginUseCase>()){
    instance.registerFactory<LoginUseCase>(()=>LoginUseCase(instance<Repository>()));

  }
}
Future<void> initUpdateMapModule() async {
  if(!GetIt.I.isRegistered<UpdateMapUsecase>()){
    instance.registerFactory<UpdateMapUsecase>(()=>UpdateMapUsecase(instance<Repository>()));

  }
}