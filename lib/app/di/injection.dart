import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:shop_ease/core/network/dio_client.dart';
import 'package:shop_ease/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:shop_ease/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:shop_ease/features/auth/domain/repositories/auth_repository.dart';
import 'package:shop_ease/features/auth/domain/usecases/login_user.dart';
import 'package:shop_ease/features/auth/presentation/bloc/login_bloc.dart';
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

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // External
  getIt
    ..registerLazySingleton<Dio>(Dio.new)
    // Infrastructure
    ..registerLazySingleton<DioClient>(() => DioClient(getIt<Dio>()))
    // Data Sources
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(getIt<DioClient>()),
    )
    ..registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(getIt<DioClient>()),
    )
    ..registerLazySingleton<ProductDetailRemoteDataSource>(
      () => ProductDetailRemoteDataSourceImpl(getIt<DioClient>()),
    )
    // Repositories
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
    )
    ..registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(getIt<ProductRemoteDataSource>()),
    )
    ..registerLazySingleton<ProductDetailRepository>(
      () => ProductDetailRepositoryImpl(getIt<ProductDetailRemoteDataSource>()),
    )
    // Use Cases
    ..registerLazySingleton<LoginUser>(() => LoginUser(getIt<AuthRepository>()))
    ..registerLazySingleton<GetProducts>(
      () => GetProducts(getIt<ProductRepository>()),
    )
    ..registerLazySingleton<GetProductDetail>(
      () => GetProductDetail(getIt<ProductDetailRepository>()),
    )
    // Blocs
    ..registerFactory<LoginBloc>(() => LoginBloc(loginUser: getIt<LoginUser>()))
    ..registerFactory<ProductsBloc>(
      () => ProductsBloc(getProducts: getIt<GetProducts>()),
    )
    ..registerFactory<ProductDetailBloc>(
      () => ProductDetailBloc(getProductDetail: getIt<GetProductDetail>()),
    );
}
