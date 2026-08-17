import 'package:equatable/equatable.dart';
import 'package:shop_ease/features/products/domain/entities/product.dart';

class ProductsPage extends Equatable {
  final List<Product> products;
  final int total;
  final int skip;
  final int limit;

  const ProductsPage({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  @override
  List<Object?> get props => [products, total, skip, limit];

  bool get isLastPage => skip + products.length >= total;
}
