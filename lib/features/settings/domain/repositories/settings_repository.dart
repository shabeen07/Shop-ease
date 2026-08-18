import 'package:dartz/dartz.dart';
import 'package:shop_ease/core/error/failures.dart';
import 'package:shop_ease/features/settings/domain/entities/app_settings.dart';

abstract class SettingsRepository {
  Future<Either<Failure, AppSettings>> getSettings();
  Future<Either<Failure, void>> updateThemeMode(AppThemeMode themeMode);
  Future<Either<Failure, void>> updateNotificationsEnabled(bool enabled);
}
