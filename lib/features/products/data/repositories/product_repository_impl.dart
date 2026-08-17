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
}
