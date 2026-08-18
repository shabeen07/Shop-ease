import 'package:dartz/dartz.dart';
import 'package:shop_ease/core/error/failures.dart';
import 'package:shop_ease/features/auth/domain/entities/authenticated_user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthenticatedUser>> login({
    required String username,
    required String password,
  });
  Future<Either<Failure, AuthenticatedUser?>> restoreSession();
  Future<void> logout();
}
