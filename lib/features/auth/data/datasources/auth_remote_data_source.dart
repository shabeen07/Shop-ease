import 'package:dio/dio.dart';

import 'package:shop_ease/core/error/exceptions.dart';
import 'package:shop_ease/core/network/dio_client.dart';
import 'package:shop_ease/features/auth/data/models/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login({
    required String username,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl(this.dioClient);

  @override
  Future<AuthResponseModel> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await dioClient.dio.post<Map<String, dynamic>>(
        '/auth/login',
        data: {'username': username, 'password': password},
      );

      if (response.statusCode == 200 && response.data != null) {
        return AuthResponseModel.fromJson(response.data!);
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(
          response.data?['message'] as String? ?? 'Invalid credentials',
        );
      } else {
        throw ServerException('Failed to login');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException(
          (e.response?.data as Map<String, dynamic>?)?['message'] as String? ??
              'Invalid credentials',
        );
      }
      throw ServerException(e.message ?? 'Network error');
    }
  }
}
