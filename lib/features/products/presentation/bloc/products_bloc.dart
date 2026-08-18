import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_ease/features/products/domain/usecases/get_categories.dart';
import 'package:shop_ease/features/products/domain/usecases/get_products.dart';
import 'package:shop_ease/features/products/domain/usecases/get_products_by_category.dart';
import 'package:shop_ease/features/products/domain/usecases/search_products.dart';
import 'package:shop_ease/features/products/presentation/bloc/products_event.dart';
import 'package:shop_ease/features/products/presentation/bloc/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase getProducts;
  final SearchProductsUseCase searchProducts;
  final GetCategoriesUseCase getCategories;
  final GetProductsByCategoryUseCase getProductsByCategory;

  ProductsBloc({
    required this.getProducts,
    required this.searchProducts,
    required this.getCategories,
    required this.getProductsByCategory,
  }) : super(const ProductsState()) {
    on<ProductsRequested>(_onProductsRequested);
    on<ProductsRefreshed>(_onProductsRefreshed);
    on<ProductsNextPageRequested>(_onProductsNextPageRequested);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<CategorySelected>(_onCategorySelected);
    on<CategoriesRequested>(_onCategoriesRequested);
  }

  Future<void> _onProductsRequested(
    ProductsRequested event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(status: ProductsStatus.loading));

    final result = await getProducts(GetProductsParams());

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ProductsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (page) {
        if (page.products.isEmpty) {
          emit(state.copyWith(status: ProductsStatus.empty));
        } else {
          emit(
            state.copyWith(
              status: ProductsStatus.success,
              products: page.products,
              hasReachedMax: page.isLastPage,
              skip: page.products.length,
            ),
          );
        }
      },
    );
  }

  Future<void> _onProductsRefreshed(
    ProductsRefreshed event,
    Emitter<ProductsState> emit,
  ) async {
    if (state.searchQuery != null && state.searchQuery!.isNotEmpty) {
      add(SearchQueryChanged(state.searchQuery!));
      return;
    }
    if (state.selectedCategory != null) {
      add(CategorySelected(state.selectedCategory!));
      return;
    }

    final result = await getProducts(GetProductsParams());

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ProductsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (page) {
        if (page.products.isEmpty) {
          emit(state.copyWith(status: ProductsStatus.empty, products: []));
        } else {
          emit(
            state.copyWith(
              status: ProductsStatus.success,
              products: page.products,
              hasReachedMax: page.isLastPage,
              skip: page.products.length,
            ),
          );
        }
      },
    );
  }

  Future<void> _onProductsNextPageRequested(
    ProductsNextPageRequested event,
    Emitter<ProductsState> emit,
  ) async {
    if (state.hasReachedMax ||
        state.status == ProductsStatus.loading ||
        state.searchQuery != null ||
        state.selectedCategory != null) {
      return;
    }

    final result = await getProducts(GetProductsParams(skip: state.skip));

    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (page) {
        emit(
          state.copyWith(
            status: ProductsStatus.success,
            products: List.of(state.products)..addAll(page.products),
            hasReachedMax: page.isLastPage,
            skip: state.skip + page.products.length,
          ),
        );
      },
    );
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<ProductsState> emit,
  ) async {
    if (event.query.isEmpty) {
      add(ProductsRequested());
      return;
    }

    emit(
      state.copyWith(status: ProductsStatus.loading, searchQuery: event.query),
    );

    final result = await searchProducts(event.query);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ProductsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (page) {
        if (page.products.isEmpty) {
          emit(state.copyWith(status: ProductsStatus.empty, products: []));
        } else {
          emit(
            state.copyWith(
              status: ProductsStatus.success,
              products: page.products,
              hasReachedMax: true,
            ),
          );
        }
      },
    );
  }

  Future<void> _onCategorySelected(
    CategorySelected event,
    Emitter<ProductsState> emit,
  ) async {
    if (event.category == 'All') {
      add(ProductsRequested());
      return;
    }

    emit(
      state.copyWith(
        status: ProductsStatus.loading,
        selectedCategory: event.category,
      ),
    );

    final result = await getProductsByCategory(event.category);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ProductsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (page) {
        if (page.products.isEmpty) {
          emit(state.copyWith(status: ProductsStatus.empty, products: []));
        } else {
          emit(
            state.copyWith(
              status: ProductsStatus.success,
              products: page.products,
              hasReachedMax: true,
            ),
          );
        }
      },
    );
  }

  Future<void> _onCategoriesRequested(
    CategoriesRequested event,
    Emitter<ProductsState> emit,
  ) async {
    final result = await getCategories();
    result.fold(
      (failure) => null,
      (categories) => emit(state.copyWith(categories: ['All', ...categories])),
    );
  }
}
