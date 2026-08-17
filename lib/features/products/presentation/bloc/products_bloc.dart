import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_ease/features/products/domain/usecases/get_products.dart';
import 'package:shop_ease/features/products/presentation/bloc/products_event.dart';
import 'package:shop_ease/features/products/presentation/bloc/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProducts getProducts;

  ProductsBloc({required this.getProducts}) : super(const ProductsState()) {
    on<ProductsRequested>(_onProductsRequested);
    on<ProductsRefreshed>(_onProductsRefreshed);
    on<ProductsNextPageRequested>(_onProductsNextPageRequested);
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
    if (state.hasReachedMax || state.status == ProductsStatus.loading) return;

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
}
