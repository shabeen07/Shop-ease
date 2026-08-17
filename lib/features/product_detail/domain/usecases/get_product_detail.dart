import 'package:dartz/dartz.dart';
import 'package:shop_ease/core/error/failures.dart';
import 'package:shop_ease/features/product_detail/domain/entities/product_detail.dart';
import 'package:shop_ease/features/product_detail/domain/repositories/product_detail_repository.dart';

class GetProductDetail {
  final ProductDetailRepository repository;

  GetProductDetail(this.repository);

  Future<Either<Failure, ProductDetail>> call(int id) async =>
      await repository.getProductDetail(id);
}
