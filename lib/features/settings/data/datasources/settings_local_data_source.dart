import 'package:shop_ease/core/storage/local_storage.dart';
import 'package:shop_ease/features/settings/domain/entities/app_settings.dart';

abstract class SettingsLocalDataSource {
  Future<AppThemeMode> getThemeMode();
  Future<void> cacheThemeMode(AppThemeMode themeMode);
  Future<bool> getNotificationsEnabled();
  Future<void> cacheNotificationsEnabled(bool enabled);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final LocalStorage localStorage;
  static const _themeModeKey = 'theme_mode';
  static const _notificationsEnabledKey = 'notifications_enabled';

  SettingsLocalDataSourceImpl(this.localStorage);

  @override
  Future<AppThemeMode> getThemeMode() async {
    final mode = localStorage.getString(_themeModeKey);
    if (mode == null) return AppThemeMode.system;
    return AppThemeMode.values.firstWhere(
      (e) => e.name == mode,
      orElse: () => AppThemeMode.system,
    );
  }

  @override
  Future<void> cacheThemeMode(AppThemeMode themeMode) async {
    await localStorage.setString(_themeModeKey, themeMode.name);
  }

  @override
  Future<bool> getNotificationsEnabled() async {
    final enabled = localStorage.getString(_notificationsEnabledKey);
    return enabled == 'true';
  }

  @override
  Future<void> cacheNotificationsEnabled(bool enabled) async {
    await localStorage.setString(_notificationsEnabledKey, enabled.toString());
  }
}
