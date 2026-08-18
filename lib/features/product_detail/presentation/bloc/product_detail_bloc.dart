import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_ease/features/product_detail/domain/usecases/get_product_detail.dart';
import 'package:shop_ease/features/product_detail/presentation/bloc/product_detail_event.dart';
import 'package:shop_ease/features/product_detail/presentation/bloc/product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final GetProductDetailUseCase getProductDetail;

  ProductDetailBloc({required this.getProductDetail})
    : super(ProductInitial()) {
    on<ProductRequested>(_onProductRequested);
  }

  Future<void> _onProductRequested(
    ProductRequested event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductLoading());

    final result = await getProductDetail(event.id);

    result.fold(
      (failure) => emit(ProductFailure(failure.message)),
      (product) => emit(ProductSuccess(product)),
    );
  }
}
