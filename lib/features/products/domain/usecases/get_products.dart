import 'package:dartz/dartz.dart';

import 'package:shop_ease/core/error/failures.dart';
import 'package:shop_ease/features/products/domain/entities/products_page.dart';
import 'package:shop_ease/features/products/domain/repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<Either<Failure, ProductsPage>> call(GetProductsParams params) async =>
      await repository.getProducts(limit: params.limit, skip: params.skip);
}

class GetProductsParams {
  final int limit;
  final int skip;

  GetProductsParams({this.limit = 20, this.skip = 0});
}
