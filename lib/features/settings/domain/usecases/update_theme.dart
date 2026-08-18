import 'package:dartz/dartz.dart';
import 'package:shop_ease/core/error/failures.dart';
import 'package:shop_ease/features/settings/domain/entities/app_settings.dart';
import 'package:shop_ease/features/settings/domain/repositories/settings_repository.dart';

class UpdateThemeUseCase {
  final SettingsRepository repository;

  UpdateThemeUseCase(this.repository);

  Future<Either<Failure, void>> call(AppThemeMode themeMode) async =>
      await repository.updateThemeMode(themeMode);
}
