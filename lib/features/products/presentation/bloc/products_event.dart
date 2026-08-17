import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class ProductsRequested extends ProductsEvent {}

class ProductsRefreshed extends ProductsEvent {}

class ProductsNextPageRequested extends ProductsEvent {}
