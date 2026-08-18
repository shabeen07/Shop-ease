import 'package:dartz/dartz.dart';
import 'package:shop_ease/core/error/failures.dart';
import 'package:shop_ease/features/product_detail/domain/entities/product_detail.dart';

abstract class ProductDetailRepository {
  Future<Either<Failure, ProductDetail>> getProductDetail(int id);
}
