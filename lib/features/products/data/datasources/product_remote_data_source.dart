import 'package:dio/dio.dart';

import 'package:shop_ease/core/error/exceptions.dart';
import 'package:shop_ease/core/network/dio_client.dart';
import 'package:shop_ease/features/products/data/models/products_response_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductsResponseModel> getProducts({
    required int limit,
    required int skip,
  });
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
}
