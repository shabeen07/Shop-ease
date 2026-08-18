import 'package:dartz/dartz.dart';
import 'package:shop_ease/core/error/failures.dart';
import 'package:shop_ease/features/settings/domain/entities/app_settings.dart';
import 'package:shop_ease/features/settings/domain/repositories/settings_repository.dart';

class GetSettings {
  final SettingsRepository repository;

  GetSettings(this.repository);

  Future<Either<Failure, AppSettings>> call() async =>
      await repository.getSettings();
}
