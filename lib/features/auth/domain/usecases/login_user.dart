import 'package:dartz/dartz.dart';
import 'package:shop_ease/core/error/failures.dart';
import 'package:shop_ease/features/auth/domain/entities/authenticated_user.dart';
import 'package:shop_ease/features/auth/domain/repositories/auth_repository.dart';

class LoginUserUseCase {
  final AuthRepository repository;

  LoginUserUseCase(this.repository);

  Future<Either<Failure, AuthenticatedUser>> call(LoginParams params) async =>
      await repository.login(
        username: params.username,
        password: params.password,
      );
}

class LoginParams {
  final String username;
  final String password;

  LoginParams({required this.username, required this.password});
}
