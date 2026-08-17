import 'package:dartz/dartz.dart';
import 'package:shop_ease/core/error/exceptions.dart';
import 'package:shop_ease/core/error/failures.dart';
import 'package:shop_ease/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:shop_ease/features/auth/domain/entities/authenticated_user.dart';
import 'package:shop_ease/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AuthenticatedUser>> login({
    required String username,
    required String password,
  }) async {
    try {
      final responseModel = await remoteDataSource.login(
        username: username,
        password: password,
      );
      return Right(responseModel.toEntity());
    } on UnauthorizedException catch (e) {
      return Left(
        UnauthorizedFailure(e.message ?? 'Invalid username or password'),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error occurred'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
