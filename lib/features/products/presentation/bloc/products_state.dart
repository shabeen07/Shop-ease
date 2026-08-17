import 'package:equatable/equatable.dart';

import 'package:shop_ease/features/products/domain/entities/product.dart';

enum ProductsStatus { initial, loading, success, failure, empty }

class ProductsState extends Equatable {
  final ProductsStatus status;
  final List<Product> products;
  final String? errorMessage;
  final bool hasReachedMax;
  final int skip;

  const ProductsState({
    this.status = ProductsStatus.initial,
    this.products = const [],
    this.errorMessage,
    this.hasReachedMax = false,
    this.skip = 0,
  });

  ProductsState copyWith({
    ProductsStatus? status,
    List<Product>? products,
    String? errorMessage,
    bool? hasReachedMax,
    int? skip,
  }) => ProductsState(
    status: status ?? this.status,
    products: products ?? this.products,
    errorMessage: errorMessage ?? this.errorMessage,
    hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    skip: skip ?? this.skip,
  );

  @override
  List<Object?> get props => [
    status,
    products,
    errorMessage,
    hasReachedMax,
    skip,
  ];
}
