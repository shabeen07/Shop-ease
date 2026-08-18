import 'package:equatable/equatable.dart';
import 'package:shop_ease/features/settings/domain/entities/app_settings.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
  @override
  List<Object?> get props => [];
}

class SettingsLoadRequested extends SettingsEvent {}

class ThemeModeChanged extends SettingsEvent {
  final AppThemeMode themeMode;
  const ThemeModeChanged(this.themeMode);
  @override
  List<Object?> get props => [themeMode];
}

class NotificationsEnabledChanged extends SettingsEvent {
  final bool enabled;
  const NotificationsEnabledChanged(this.enabled);
  @override
  List<Object?> get props => [enabled];
}
