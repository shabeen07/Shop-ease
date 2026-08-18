import 'package:dartz/dartz.dart';
import 'package:shop_ease/core/error/failures.dart';
import 'package:shop_ease/features/auth/domain/entities/authenticated_user.dart';
import 'package:shop_ease/features/auth/domain/repositories/auth_repository.dart';

class RestoreSession {
  final AuthRepository repository;

  RestoreSession(this.repository);

  Future<Either<Failure, AuthenticatedUser?>> call() async =>
      await repository.restoreSession();
}
