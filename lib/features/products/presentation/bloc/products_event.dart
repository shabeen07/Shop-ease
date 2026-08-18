import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class ProductsRequested extends ProductsEvent {}

class ProductsRefreshed extends ProductsEvent {}

class ProductsNextPageRequested extends ProductsEvent {}

class SearchQueryChanged extends ProductsEvent {
  final String query;
  const SearchQueryChanged(this.query);
  @override
  List<Object?> get props => [query];
}

class CategorySelected extends ProductsEvent {
  final String category;
  const CategorySelected(this.category);
  @override
  List<Object?> get props => [category];
}

class CategoriesRequested extends ProductsEvent {}
