import 'package:dartz/dartz.dart';
import 'package:shop_ease/core/error/exceptions.dart';
import 'package:shop_ease/core/error/failures.dart';
import 'package:shop_ease/features/product_detail/data/datasources/product_detail_remote_data_source.dart';
import 'package:shop_ease/features/product_detail/domain/entities/product_detail.dart';
import 'package:shop_ease/features/product_detail/domain/repositories/product_detail_repository.dart';

class ProductDetailRepositoryImpl implements ProductDetailRepository {
  final ProductDetailRemoteDataSource remoteDataSource;

  ProductDetailRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ProductDetail>> getProductDetail(int id) async {
    try {
      final responseModel = await remoteDataSource.getProductDetail(id);
      return Right(responseModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error occurred'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
