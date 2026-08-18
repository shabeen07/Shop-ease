import 'package:dartz/dartz.dart';
import 'package:shop_ease/core/error/failures.dart';
import 'package:shop_ease/features/products/domain/entities/products_page.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductsPage>> getProducts({
    required int limit,
    required int skip,
  });
  Future<Either<Failure, ProductsPage>> searchProducts(String query);
  Future<Either<Failure, List<String>>> getCategories();
  Future<Either<Failure, ProductsPage>> getProductsByCategory(String category);
}
