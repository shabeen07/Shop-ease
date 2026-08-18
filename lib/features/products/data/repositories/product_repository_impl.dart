import 'package:dartz/dartz.dart';
import 'package:shop_ease/core/error/exceptions.dart';
import 'package:shop_ease/core/error/failures.dart';
import 'package:shop_ease/features/products/data/datasources/product_remote_data_source.dart';
import 'package:shop_ease/features/products/domain/entities/products_page.dart';
import 'package:shop_ease/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ProductsPage>> getProducts({
    required int limit,
    required int skip,
  }) async {
    try {
      final responseModel = await remoteDataSource.getProducts(
        limit: limit,
        skip: skip,
      );
      return Right(responseModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error occurred'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductsPage>> searchProducts(String query) async {
    try {
      final responseModel = await remoteDataSource.searchProducts(query);
      return Right(responseModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Search failed'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to load categories'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductsPage>> getProductsByCategory(
    String category,
  ) async {
    try {
      final responseModel = await remoteDataSource.getProductsByCategory(
        category,
      );
      return Right(responseModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Filter failed'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
