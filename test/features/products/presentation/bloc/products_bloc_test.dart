import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_ease/core/error/failures.dart';
import 'package:shop_ease/features/products/domain/entities/product.dart';
import 'package:shop_ease/features/products/domain/entities/products_page.dart';
import 'package:shop_ease/features/products/domain/usecases/get_categories.dart';
import 'package:shop_ease/features/products/domain/usecases/get_products.dart';
import 'package:shop_ease/features/products/domain/usecases/get_products_by_category.dart';
import 'package:shop_ease/features/products/domain/usecases/search_products.dart';
import 'package:shop_ease/features/products/presentation/bloc/products_bloc.dart';
import 'package:shop_ease/features/products/presentation/bloc/products_event.dart';
import 'package:shop_ease/features/products/presentation/bloc/products_state.dart';

class MockGetProductsUseCase extends Mock implements GetProductsUseCase {}

class MockSearchProductsUseCase extends Mock implements SearchProductsUseCase {}

class MockGetCategoriesUseCase extends Mock implements GetCategoriesUseCase {}

class MockGetProductsByCategoryUseCase extends Mock
    implements GetProductsByCategoryUseCase {}

void main() {
  late ProductsBloc bloc;
  late MockGetProductsUseCase mockGetProducts;
  late MockSearchProductsUseCase mockSearchProducts;
  late MockGetCategoriesUseCase mockGetCategories;
  late MockGetProductsByCategoryUseCase mockGetProductsByCategory;

  setUp(() {
    mockGetProducts = MockGetProductsUseCase();
    mockSearchProducts = MockSearchProductsUseCase();
    mockGetCategories = MockGetCategoriesUseCase();
    mockGetProductsByCategory = MockGetProductsByCategoryUseCase();
    bloc = ProductsBloc(
      getProducts: mockGetProducts,
      searchProducts: mockSearchProducts,
      getCategories: mockGetCategories,
      getProductsByCategory: mockGetProductsByCategory,
    );

    registerFallbackValue(GetProductsParams());
  });

  tearDown(() {
    bloc.close();
  });

  const tProduct = Product(
    id: 1,
    title: 'Product 1',
    description: 'Description 1',
    category: 'Category 1',
    price: 10.0,
    discountPercentage: 0.0,
    rating: 4.5,
    stock: 10,
    brand: 'Brand 1',
    thumbnail: 'thumbnail',
    images: [],
  );

  const tProductsPage = ProductsPage(
    products: [tProduct],
    total: 1,
    skip: 0,
    limit: 20,
  );

  test('initial state should be ProductsState with initial status', () {
    expect(bloc.state.status, equals(ProductsStatus.initial));
  });

  blocTest<ProductsBloc, ProductsState>(
    'should emit [loading, success] when ProductsRequested is successful',
    build: () {
      when(
        () => mockGetProducts(any()),
      ).thenAnswer((_) async => const Right(tProductsPage));
      return bloc;
    },
    act: (bloc) => bloc.add(ProductsRequested()),
    expect: () => [
      const ProductsState(status: ProductsStatus.loading),
      const ProductsState(
        status: ProductsStatus.success,
        products: [tProduct],
        hasReachedMax: true,
        skip: 1,
      ),
    ],
  );

  blocTest<ProductsBloc, ProductsState>(
    'should emit [loading, empty] when ProductsRequested returns no products',
    build: () {
      when(() => mockGetProducts(any())).thenAnswer(
        (_) async => const Right(
          ProductsPage(products: [], total: 0, skip: 0, limit: 20),
        ),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(ProductsRequested()),
    expect: () => [
      const ProductsState(status: ProductsStatus.loading),
      const ProductsState(status: ProductsStatus.empty),
    ],
  );

  blocTest<ProductsBloc, ProductsState>(
    'should emit [loading, failure] when ProductsRequested fails',
    build: () {
      when(
        () => mockGetProducts(any()),
      ).thenAnswer((_) async => const Left(ServerFailure('Error')));
      return bloc;
    },
    act: (bloc) => bloc.add(ProductsRequested()),
    expect: () => [
      const ProductsState(status: ProductsStatus.loading),
      const ProductsState(
        status: ProductsStatus.failure,
        errorMessage: 'Error',
      ),
    ],
  );
}
