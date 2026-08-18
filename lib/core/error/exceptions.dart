class ServerException implements Exception {
  final String? message;
  ServerException([this.message]);
}

class CacheException implements Exception {}

class UnauthorizedException implements Exception {
  final String? message;
  UnauthorizedException([this.message]);
}

class NetworkException implements Exception {}
