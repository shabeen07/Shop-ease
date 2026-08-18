import 'package:equatable/equatable.dart';
import 'package:shop_ease/features/product_detail/domain/entities/product_detail.dart';

abstract class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductDetailState {}

class ProductLoading extends ProductDetailState {}

class ProductSuccess extends ProductDetailState {
  final ProductDetail product;

  const ProductSuccess(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductFailure extends ProductDetailState {
  final String message;

  const ProductFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductNotFound extends ProductDetailState {}
