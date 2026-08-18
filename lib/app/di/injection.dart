import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_ease/core/network/dio_client.dart';
import 'package:shop_ease/core/storage/local_storage.dart';
import 'package:shop_ease/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:shop_ease/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:shop_ease/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:shop_ease/features/auth/domain/repositories/auth_repository.dart';
import 'package:shop_ease/features/auth/domain/usecases/login_user.dart';
import 'package:shop_ease/features/auth/domain/usecases/restore_session.dart';
import 'package:shop_ease/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shop_ease/features/auth/presentation/bloc/login_bloc.dart';
import 'package:shop_ease/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:shop_ease/features/notifications/domain/repositories/notification_repository.dart';
import 'package:shop_ease/features/product_detail/data/datasources/product_detail_remote_data_source.dart';
import 'package:shop_ease/features/product_detail/data/repositories/product_detail_repository_impl.dart';
import 'package:shop_ease/features/product_detail/domain/repositories/product_detail_repository.dart';
import 'package:shop_ease/features/product_detail/domain/usecases/get_product_detail.dart';
import 'package:shop_ease/features/product_detail/presentation/bloc/product_detail_bloc.dart';
import 'package:shop_ease/features/products/data/datasources/product_remote_data_source.dart';
import 'package:shop_ease/features/products/data/repositories/product_repository_impl.dart';
import 'package:shop_ease/features/products/domain/repositories/product_repository.dart';
import 'package:shop_ease/features/products/domain/usecases/get_products.dart';
import 'package:shop_ease/features/products/presentation/bloc/products_bloc.dart';
import 'package:shop_ease/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:shop_ease/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:shop_ease/features/settings/domain/repositories/settings_repository.dart';
import 'package:shop_ease/features/settings/domain/usecases/get_settings.dart';
import 'package:shop_ease/features/settings/domain/usecases/update_theme.dart';
import 'package:shop_ease/features/settings/presentation/bloc/settings_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt
    ..registerLazySingleton<Dio>(Dio.new)
    ..registerLazySingleton<SharedPreferences>(() => sharedPreferences)
    // Infrastructure
    ..registerLazySingleton<DioClient>(() => DioClient(getIt<Dio>()))
    ..registerLazySingleton<LocalStorage>(
      () => LocalStorage(getIt<SharedPreferences>()),
    )
    // Data Sources
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(getIt<DioClient>()),
    )
    ..registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(getIt<LocalStorage>()),
    )
    ..registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(getIt<DioClient>()),
    )
    ..registerLazySingleton<ProductDetailRemoteDataSource>(
      () => ProductDetailRemoteDataSourceImpl(getIt<DioClient>()),
    )
    ..registerLazySingleton<SettingsLocalDataSource>(
      () => SettingsLocalDataSourceImpl(getIt<LocalStorage>()),
    )
    // Repositories
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: getIt<AuthRemoteDataSource>(),
        localDataSource: getIt<AuthLocalDataSource>(),
      ),
    )
    ..registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(getIt<ProductRemoteDataSource>()),
    )
    ..registerLazySingleton<ProductDetailRepository>(
      () => ProductDetailRepositoryImpl(getIt<ProductDetailRemoteDataSource>()),
    )
    ..registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(getIt<SettingsLocalDataSource>()),
    )
    ..registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(),
    )
    // Use Cases
    ..registerLazySingleton<LoginUser>(() => LoginUser(getIt<AuthRepository>()))
    ..registerLazySingleton<RestoreSession>(
      () => RestoreSession(getIt<AuthRepository>()),
    )
    ..registerLazySingleton<GetProducts>(
      () => GetProducts(getIt<ProductRepository>()),
    )
    ..registerLazySingleton<GetProductDetail>(
      () => GetProductDetail(getIt<ProductDetailRepository>()),
    )
    ..registerLazySingleton<GetSettings>(
      () => GetSettings(getIt<SettingsRepository>()),
    )
    ..registerLazySingleton<UpdateTheme>(
      () => UpdateTheme(getIt<SettingsRepository>()),
    )
    // Blocs
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        restoreSession: getIt<RestoreSession>(),
        repository: getIt<AuthRepository>(),
      ),
    )
    ..registerFactory<LoginBloc>(() => LoginBloc(loginUser: getIt<LoginUser>()))
    ..registerFactory<ProductsBloc>(
      () => ProductsBloc(getProducts: getIt<GetProducts>()),
    )
    ..registerFactory<ProductDetailBloc>(
      () => ProductDetailBloc(getProductDetail: getIt<GetProductDetail>()),
    )
    ..registerFactory<SettingsBloc>(
      () => SettingsBloc(
        getSettings: getIt<GetSettings>(),
        updateTheme: getIt<UpdateTheme>(),
      ),
    );
}
