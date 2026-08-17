import 'package:dio/dio.dart';

import 'package:shop_ease/core/error/exceptions.dart';
import 'package:shop_ease/core/network/dio_client.dart';
import 'package:shop_ease/features/product_detail/data/models/product_detail_model.dart';

abstract class ProductDetailRemoteDataSource {
  Future<ProductDetailModel> getProductDetail(int id);
}

class ProductDetailRemoteDataSourceImpl
    implements ProductDetailRemoteDataSource {
  final DioClient dioClient;

  ProductDetailRemoteDataSourceImpl(this.dioClient);

  @override
  Future<ProductDetailModel> getProductDetail(int id) async {
    try {
      final response = await dioClient.dio.get<Map<String, dynamic>>(
        '/products/$id',
      );

      if (response.statusCode == 200 && response.data != null) {
        return ProductDetailModel.fromJson(response.data!);
      } else {
        throw ServerException('Failed to load product detail');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Network error');
    }
  }
}
