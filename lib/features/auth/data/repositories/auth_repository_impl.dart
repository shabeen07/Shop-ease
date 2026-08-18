import 'package:dartz/dartz.dart';
import 'package:shop_ease/core/error/exceptions.dart';
import 'package:shop_ease/core/error/failures.dart';
import 'package:shop_ease/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:shop_ease/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:shop_ease/features/auth/domain/entities/authenticated_user.dart';
import 'package:shop_ease/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

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
      await localDataSource.cacheUser(responseModel);
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

  @override
  Future<Either<Failure, AuthenticatedUser?>> restoreSession() async {
    try {
      final userModel = await localDataSource.getLastUser();
      return Right(userModel?.toEntity());
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearCache();
  }
}
