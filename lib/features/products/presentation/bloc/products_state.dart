import 'package:equatable/equatable.dart';
import 'package:shop_ease/features/products/domain/entities/product.dart';

enum ProductsStatus { initial, loading, success, failure, empty }

class ProductsState extends Equatable {
  final ProductsStatus status;
  final List<Product> products;
  final List<String> categories;
  final String? selectedCategory;
  final String? searchQuery;
  final String? errorMessage;
  final bool hasReachedMax;
  final int skip;

  const ProductsState({
    this.status = ProductsStatus.initial,
    this.products = const [],
    this.categories = const [],
    this.selectedCategory,
    this.searchQuery,
    this.errorMessage,
    this.hasReachedMax = false,
    this.skip = 0,
  });

  ProductsState copyWith({
    ProductsStatus? status,
    List<Product>? products,
    List<String>? categories,
    String? selectedCategory,
    String? searchQuery,
    String? errorMessage,
    bool? hasReachedMax,
    int? skip,
  }) => ProductsState(
    status: status ?? this.status,
    products: products ?? this.products,
    categories: categories ?? this.categories,
    selectedCategory: selectedCategory ?? this.selectedCategory,
    searchQuery: searchQuery ?? this.searchQuery,
    errorMessage: errorMessage ?? this.errorMessage,
    hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    skip: skip ?? this.skip,
  );

  @override
  List<Object?> get props => [
    status,
    products,
    categories,
    selectedCategory,
    searchQuery,
    errorMessage,
    hasReachedMax,
    skip,
  ];
}
