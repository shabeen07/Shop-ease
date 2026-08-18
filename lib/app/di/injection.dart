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
import 'package:shop_ease/features/products/domain/usecases/get_categories.dart';
import 'package:shop_ease/features/products/domain/usecases/get_products.dart';
import 'package:shop_ease/features/products/domain/usecases/get_products_by_category.dart';
import 'package:shop_ease/features/products/domain/usecases/search_products.dart';
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
    ..registerLazySingleton<LoginUserUseCase>(
      () => LoginUserUseCase(getIt<AuthRepository>()),
    )
    ..registerLazySingleton<RestoreSessionUseCase>(
      () => RestoreSessionUseCase(getIt<AuthRepository>()),
    )
    ..registerLazySingleton<GetProductsUseCase>(
      () => GetProductsUseCase(getIt<ProductRepository>()),
    )
    ..registerLazySingleton<SearchProductsUseCase>(
      () => SearchProductsUseCase(getIt<ProductRepository>()),
    )
    ..registerLazySingleton<GetCategoriesUseCase>(
      () => GetCategoriesUseCase(getIt<ProductRepository>()),
    )
    ..registerLazySingleton<GetProductsByCategoryUseCase>(
      () => GetProductsByCategoryUseCase(getIt<ProductRepository>()),
    )
    ..registerLazySingleton<GetProductDetailUseCase>(
      () => GetProductDetailUseCase(getIt<ProductDetailRepository>()),
    )
    ..registerLazySingleton<GetSettingsUseCase>(
      () => GetSettingsUseCase(getIt<SettingsRepository>()),
    )
    ..registerLazySingleton<UpdateThemeUseCase>(
      () => UpdateThemeUseCase(getIt<SettingsRepository>()),
    )
    // Blocs
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        restoreSession: getIt<RestoreSessionUseCase>(),
        repository: getIt<AuthRepository>(),
      ),
    )
    ..registerFactory<LoginBloc>(
      () => LoginBloc(loginUser: getIt<LoginUserUseCase>()),
    )
    ..registerFactory<ProductsBloc>(
      () => ProductsBloc(
        getProducts: getIt<GetProductsUseCase>(),
        searchProducts: getIt<SearchProductsUseCase>(),
        getCategories: getIt<GetCategoriesUseCase>(),
        getProductsByCategory: getIt<GetProductsByCategoryUseCase>(),
      ),
    )
    ..registerFactory<ProductDetailBloc>(
      () =>
          ProductDetailBloc(getProductDetail: getIt<GetProductDetailUseCase>()),
    )
    ..registerFactory<SettingsBloc>(
      () => SettingsBloc(
        getSettings: getIt<GetSettingsUseCase>(),
        updateTheme: getIt<UpdateThemeUseCase>(),
      ),
    );
}
