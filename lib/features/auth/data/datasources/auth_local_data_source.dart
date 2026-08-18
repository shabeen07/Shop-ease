import 'dart:convert';
import 'package:shop_ease/core/storage/local_storage.dart';
import 'package:shop_ease/features/auth/data/models/auth_response_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(AuthResponseModel user);
  Future<AuthResponseModel?> getLastUser();
  Future<void> clearCache();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorage localStorage;
  static const _userKey = 'cached_user';

  AuthLocalDataSourceImpl(this.localStorage);

  @override
  Future<void> cacheUser(AuthResponseModel user) async {
    await localStorage.setString(_userKey, jsonEncode(user.toJson()));
  }

  @override
  Future<AuthResponseModel?> getLastUser() async {
    final jsonString = localStorage.getString(_userKey);
    if (jsonString != null) {
      return AuthResponseModel.fromJson(
        jsonDecode(jsonString) as Map<String, dynamic>,
      );
    }
    return null;
  }

  @override
  Future<void> clearCache() async {
    await localStorage.remove(_userKey);
  }
}
