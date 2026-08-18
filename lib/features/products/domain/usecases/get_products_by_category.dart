import 'package:dartz/dartz.dart';
import 'package:shop_ease/core/error/failures.dart';
import 'package:shop_ease/features/products/domain/entities/products_page.dart';
import 'package:shop_ease/features/products/domain/repositories/product_repository.dart';

class GetProductsByCategoryUseCase {
  final ProductRepository repository;

  GetProductsByCategoryUseCase(this.repository);

  Future<Either<Failure, ProductsPage>> call(String category) async =>
      await repository.getProductsByCategory(category);
}
