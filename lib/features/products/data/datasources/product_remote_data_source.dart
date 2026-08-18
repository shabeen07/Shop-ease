import 'package:dio/dio.dart';
import 'package:shop_ease/core/error/exceptions.dart';
import 'package:shop_ease/core/network/dio_client.dart';
import 'package:shop_ease/features/products/data/models/products_response_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductsResponseModel> getProducts({
    required int limit,
    required int skip,
  });
  Future<ProductsResponseModel> searchProducts(String query);
  Future<List<String>> getCategories();
  Future<ProductsResponseModel> getProductsByCategory(String category);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioClient dioClient;

  ProductRemoteDataSourceImpl(this.dioClient);

  @override
  Future<ProductsResponseModel> getProducts({
    required int limit,
    required int skip,
  }) async {
    try {
      final response = await dioClient.dio.get<Map<String, dynamic>>(
        '/products',
        queryParameters: {'limit': limit, 'skip': skip},
      );

      if (response.statusCode == 200 && response.data != null) {
        return ProductsResponseModel.fromJson(response.data!);
      } else {
        throw ServerException('Failed to load products');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Network error');
    }
  }

  @override
  Future<ProductsResponseModel> searchProducts(String query) async {
    try {
      final response = await dioClient.dio.get<Map<String, dynamic>>(
        '/products/search',
        queryParameters: {'q': query},
      );

      if (response.statusCode == 200 && response.data != null) {
        return ProductsResponseModel.fromJson(response.data!);
      } else {
        throw ServerException('Search failed');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Network error');
    }
  }

  @override
  Future<List<String>> getCategories() async {
    try {
      final response = await dioClient.dio.get<List<dynamic>>(
        '/products/categories',
      );
      if (response.statusCode == 200 && response.data != null) {
        return response.data!.map((e) {
          if (e is Map<String, dynamic>) {
            return e['name'] as String? ?? e['slug'] as String? ?? e.toString();
          }
          return e.toString();
        }).toList();
      } else {
        throw ServerException('Failed to load categories');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Network error');
    }
  }

  @override
  Future<ProductsResponseModel> getProductsByCategory(String category) async {
    try {
      final response = await dioClient.dio.get<Map<String, dynamic>>(
        '/products/category/$category',
      );

      if (response.statusCode == 200 && response.data != null) {
        return ProductsResponseModel.fromJson(response.data!);
      } else {
        throw ServerException('Failed to filter by category');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Network error');
    }
  }
}
