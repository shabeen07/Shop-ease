import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_ease/core/error/failures.dart';
import 'package:shop_ease/features/product_detail/domain/entities/product_detail.dart';
import 'package:shop_ease/features/product_detail/domain/usecases/get_product_detail.dart';
import 'package:shop_ease/features/product_detail/presentation/bloc/product_detail_bloc.dart';
import 'package:shop_ease/features/product_detail/presentation/bloc/product_detail_event.dart';
import 'package:shop_ease/features/product_detail/presentation/bloc/product_detail_state.dart';

class MockGetProductDetail extends Mock implements GetProductDetail {}

void main() {
  late ProductDetailBloc bloc;
  late MockGetProductDetail mockGetProductDetail;

  setUp(() {
    mockGetProductDetail = MockGetProductDetail();
    bloc = ProductDetailBloc(getProductDetail: mockGetProductDetail);
  });

  tearDown(() {
    bloc.close();
  });

  const tProductId = 1;
  const tProductDetail = ProductDetail(
    id: 1,
    title: 'Product 1',
    description: 'Description 1',
    category: 'Category 1',
    price: 10.0,
    discountPercentage: 0.0,
    rating: 4.5,
    stock: 10,
    brand: 'Brand 1',
    sku: 'SKU123',
    warrantyInformation: '1 year',
    shippingInformation: '1 week',
    availabilityStatus: 'In Stock',
    returnPolicy: '30 days',
    thumbnail: 'thumbnail',
    images: [],
  );

  test('initial state should be ProductInitial', () {
    expect(bloc.state, equals(ProductInitial()));
  });

  blocTest<ProductDetailBloc, ProductDetailState>(
    'should emit [ProductLoading, ProductSuccess] when ProductRequested is successful',
    build: () {
      when(
        () => mockGetProductDetail(any()),
      ).thenAnswer((_) async => const Right(tProductDetail));
      return bloc;
    },
    act: (bloc) => bloc.add(const ProductRequested(tProductId)),
    expect: () => [ProductLoading(), const ProductSuccess(tProductDetail)],
  );

  blocTest<ProductDetailBloc, ProductDetailState>(
    'should emit [ProductLoading, ProductFailure] when ProductRequested fails',
    build: () {
      when(
        () => mockGetProductDetail(any()),
      ).thenAnswer((_) async => const Left(ServerFailure('Error')));
      return bloc;
    },
    act: (bloc) => bloc.add(const ProductRequested(tProductId)),
    expect: () => [ProductLoading(), const ProductFailure('Error')],
  );
}
