import 'package:dartz/dartz.dart';
import 'package:shop_ease/core/error/failures.dart';
import 'package:shop_ease/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:shop_ease/features/settings/domain/entities/app_settings.dart';
import 'package:shop_ease/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, AppSettings>> getSettings() async {
    try {
      final themeMode = await localDataSource.getThemeMode();
      final notificationsEnabled = await localDataSource
          .getNotificationsEnabled();
      return Right(
        AppSettings(
          themeMode: themeMode,
          notificationsEnabled: notificationsEnabled,
        ),
      );
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateThemeMode(AppThemeMode themeMode) async {
    try {
      await localDataSource.cacheThemeMode(themeMode);
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateNotificationsEnabled(bool enabled) async {
    try {
      await localDataSource.cacheNotificationsEnabled(enabled);
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure(e.toString()));
    }
  }
}
