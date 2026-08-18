import 'package:equatable/equatable.dart';
import 'package:shop_ease/features/settings/domain/entities/app_settings.dart';

enum SettingsStatus { initial, loading, loaded, failure }

class SettingsState extends Equatable {
  final SettingsStatus status;
  final AppSettings settings;
  final String? errorMessage;

  const SettingsState({
    this.status = SettingsStatus.initial,
    this.settings = const AppSettings(
      themeMode: AppThemeMode.system,
      notificationsEnabled: true,
    ),
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, settings, errorMessage];

  SettingsState copyWith({
    SettingsStatus? status,
    AppSettings? settings,
    String? errorMessage,
  }) => SettingsState(
    status: status ?? this.status,
    settings: settings ?? this.settings,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
